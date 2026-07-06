/*
 *  Created by Mithil Devkar
 *  Logging Interceptor
 */

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    log(
      '''
==================== API REQUEST ====================

METHOD : ${options.method}
URL    : ${options.uri}

HEADERS:
${const JsonEncoder.withIndent('  ').convert(options.headers)}

QUERY:
${const JsonEncoder.withIndent('  ').convert(options.queryParameters)}

BODY:
${options.data == null ? "No Body" : const JsonEncoder.withIndent('  ').convert(options.data)}

======================================================
''',
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    log(
      '''
==================== API RESPONSE ====================

STATUS : ${response.statusCode}
METHOD : ${response.requestOptions.method}
URL    : ${response.requestOptions.uri}

BODY:
${const JsonEncoder.withIndent('  ').convert(response.data)}

======================================================
''',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    log(
      '''
==================== API ERROR =======================

STATUS : ${err.response?.statusCode}
METHOD : ${err.requestOptions.method}
URL    : ${err.requestOptions.uri}

REQUEST:
${err.requestOptions.data ?? "No Body"}

RESPONSE:
${err.response?.data ?? "No Response"}

======================================================
''',
    );

    super.onError(err, handler);
  }
}