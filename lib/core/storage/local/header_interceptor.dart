/*
 *  Created by Mithil Devkar
 *  Header Interceptor
 */

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../global/app_storage.dart';

bool _isUnauthorized = false;

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor();

  final Uuid _uuid = const Uuid();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    options.headers.addAll(await _headers);

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final statusCode = err.response?.statusCode;

    final isLoggedIn =
        AppStorage.instance.getValue<bool>(StorageKey.isLoggedIn) ?? false;

    if (statusCode == 401 &&
        !_isUnauthorized &&
        isLoggedIn &&
        !_isAuthenticationRequest(err.requestOptions.path)) {
      _isUnauthorized = true;

      await _logoutUser();
    }

    handler.next(err);
  }

  bool _isAuthenticationRequest(String path) {
    final endpoint = path.toLowerCase();

    return endpoint.contains("login") ||
        endpoint.contains("authenticate") ||
        endpoint.contains("refresh-token");
  }

  Future<void> _logoutUser() async {
    await AppStorage.instance.clearAll();

    Get.deleteAll(force: true);

    /// TODO:
    /// Replace LoginPage() with your actual login screen.
    ///
    /// Example:
    /// Get.offAll(() => const LoginPage());

    Get.snackbar(
      "Session Expired",
      "Your session has expired. Please login again.",
      snackPosition: SnackPosition.BOTTOM,
    );

    _isUnauthorized = false;
  }

  Future<Map<String, String>> get _headers async {
    final packageInfo = await PackageInfo.fromPlatform();

    final loggedIn =
        AppStorage.instance.getValue<bool>(StorageKey.isLoggedIn) ?? false;

    final headers = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',

      'x-platform': Platform.isAndroid ? 'android' : 'ios',

      'x-app-version': packageInfo.version,

      'x-app-build-number': packageInfo.buildNumber,

      'x-request-id': _uuid.v4(),

      'x-timestamp': DateTime.now().toUtc().toIso8601String(),

      'x-device-name':
      Platform.isAndroid ? 'Android Device' : 'iOS Device',
    };

    if (loggedIn) {
      final token =
          AppStorage.instance.getValue<String>(StorageKey.accessToken) ?? '';

      if (token.isNotEmpty) {
        if (kDebugMode) {
          debugPrint('Bearer Token => $token');
        }

        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }
    }

    return headers;
  }

  //--------------------------------------------------------------------------
  // Device Info (Optional for debugging)
  //--------------------------------------------------------------------------

  Future<void> printDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;

      debugPrint('Device : ${android.model}');
      debugPrint('Android : ${android.version.release}');
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;

      debugPrint('Device : ${ios.model}');
      debugPrint('iOS : ${ios.systemVersion}');
    }
  }
}