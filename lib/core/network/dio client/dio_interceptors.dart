import 'dart:developer';
import 'package:celevo/core/network/dio%20client/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor {
  final Future<String?> Function() getToken;

  DioInterceptor({required this.getToken});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (kDebugMode) {
      log('''
╔════════════════ REQUEST ════════════════
║ ${options.method} ${options.uri}
║ Headers: ${options.headers}
║ Body: ${options.data}
╚═════════════════════════════════════════
''');
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      log('''
╔════════════════ RESPONSE ═══════════════
║ Status: ${response.statusCode}
║ URL: ${response.requestOptions.uri}
║ Data: ${response.data}
╚═════════════════════════════════════════
''');
    }

    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final message = DioExceptionHandler.handle(err);

    log('''
╔════════════════ ERROR ════════════════
║ Status: ${err.response?.statusCode}
║ Message: $message
╚═════════════════════════════════════════
''');

    handler.next(err);
  }
}
