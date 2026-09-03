import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_config.dart';
import 'package:dio/dio.dart';

class DioApiService implements BaseApiService {
  DioApiService._();
  static final DioApiService _instance = DioApiService._();
  factory DioApiService() => _instance;

  final Dio _dio = DioConfig().dio;

  @override
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: queryParameters, 
      );
      return response; 
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
