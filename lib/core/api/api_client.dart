/*
 *  Created by Mithil Devkar
 *  API Client
 */

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/local/header_interceptor.dart';
import '../storage/local/logging_interceptor.dart';




enum HttpMethod { get, post, put, delete }

class ApiClient {
  ApiClient._() {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    _dio.interceptors.add(HeaderInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  static final ApiClient _client = ApiClient._();

  static ApiClient get client => _client;

  final Dio _dio = Dio();

  //--------------------------------------------------------------------------
  // GET
  //--------------------------------------------------------------------------

  Future<dynamic> get(
      String endpoint, {
        Map<String, dynamic> query = const {},
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: query,
        options: options,
      );

      if (response.data is String) {
        return jsonDecode(response.data);
      }

      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  //--------------------------------------------------------------------------
  // POST
  //--------------------------------------------------------------------------

  Future<dynamic> post(
      String endpoint,
      dynamic body,
      ) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(body),
      );

      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  //--------------------------------------------------------------------------
  // PUT
  //--------------------------------------------------------------------------

  Future<dynamic> put(
      String endpoint,
      dynamic body,
      ) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: jsonEncode(body),
      );

      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  //--------------------------------------------------------------------------
  // DELETE
  //--------------------------------------------------------------------------

  Future<dynamic> delete(
      String endpoint, {
        dynamic body,
      }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: body != null ? jsonEncode(body) : null,
      );

      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  //--------------------------------------------------------------------------
  // MULTIPART
  //--------------------------------------------------------------------------

  Future<dynamic> multipart(
      String endpoint, {
        Map<String, String> body = const {},
        Map<String, String> files = const {},
        HttpMethod method = HttpMethod.post,
      }) async {
    try {
      final Map<String, dynamic> request = {};

      if (body.isNotEmpty) {
        request.addAll(body);
      }

      if (files.isNotEmpty) {
        for (final file in files.entries) {
          request[file.key] = await MultipartFile.fromFile(
            file.value,
            filename: file.value.split('/').last,
          );
        }
      }

      final formData = FormData.fromMap(request);

      final response = await _dio.request(
        endpoint,
        data: formData,
        options: Options(
          method: method == HttpMethod.put ? 'PUT' : 'POST',
        ),
      );

      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  //--------------------------------------------------------------------------
  // SINGLE FILE UPLOAD
  //--------------------------------------------------------------------------

  Future<dynamic> uploadFile(
      String endpoint, {
        required String filePath,
        required String fileField,
        Map<String, String> fields = const {},
        HttpMethod method = HttpMethod.put,
      }) async {
    try {
      final formData = FormData.fromMap({
        fileField: await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
        ...fields,
      });

      final response = await _dio.request(
        endpoint,
        data: formData,
        options: Options(
          method: method == HttpMethod.put ? 'PUT' : 'POST',
        ),
      );

      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  //--------------------------------------------------------------------------
  // INTERNET
  //--------------------------------------------------------------------------

  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty &&
          result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  //--------------------------------------------------------------------------
  // ERROR
  //--------------------------------------------------------------------------

  Future<dynamic> _handleError(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;

      switch (error.type) {
        case DioExceptionType.connectionError:
          return Future.error(
            'Looks like you are not connected to the internet.',
          );

        case DioExceptionType.connectionTimeout:
          return Future.error(
            'Server is taking too long to respond.',
          );

        case DioExceptionType.receiveTimeout:
          return Future.error(
            'Server response timed out.',
          );

        default:
          break;
      }

      if (data is Uint8List) {
        final temp = jsonDecode(utf8.decode(data));

        return Future.error(
          temp['message'] ??
              temp['error'] ??
              'Something went wrong.',
        );
      }

      return Future.error(_parseData(data));
    }

    return Future.error('Something went wrong.');
  }

  String _parseData(dynamic response) {
    try {
      return response['error'] ??
          response['message'] ??
          'Something went wrong.';
    } catch (_) {
      return 'Something went wrong.';
    }
  }
}