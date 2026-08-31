import 'package:celevo/core/constants/api_constants.dart';
import 'package:celevo/core/network/dio%20client/dio_interceptors.dart';
import 'package:dio/dio.dart';

class DioConfig {
  DioConfig._();
  static final DioConfig _instance = DioConfig._();
  factory DioConfig() => _instance;
  late final Dio dio = _createDio();
  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    dio.interceptors.add(
      DioInterceptor(
        getToken: () async {
          return null; 
        },
      ),
    );
    return dio;
  }
}
