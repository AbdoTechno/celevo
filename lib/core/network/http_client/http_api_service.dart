import 'dart:convert';
import 'dart:io';
import 'package:celevo/core/constants/api_constants.dart';
import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/http_client/http_exception.dart';
import 'package:http/http.dart' as http;

class HttpResponseData {
  final dynamic data;
  final int statusCode;
  final Map<String, String> headers;

  const HttpResponseData({
    required this.data,
    required this.statusCode,
    this.headers = const {},
  });
}

class HttpApiService implements BaseApiService {
  HttpApiService._();
  static final HttpApiService _instance = HttpApiService._();
  factory HttpApiService() => _instance;

  final http.Client _client = http.Client();

  Uri _buildUri(String url, Map<String, dynamic>? queryParameters) {
    String fullUrl = url.startsWith('http') ? url : '${ApiConstants.baseUrl}$url';
    final uri = Uri.parse(fullUrl);
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryParams = <String, String>{
        ...uri.queryParameters,
        ...queryParameters.map((k, v) => MapEntry(k, v.toString())),
      };
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  Map<String, String> _defaultHeaders(Map<String, String>? headers) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      ...?headers,
    };
  }

  dynamic _processResponse(http.Response response) {
    dynamic decodedData;
    try {
      if (response.body.isNotEmpty) {
        decodedData = jsonDecode(response.body);
      }
    } catch (_) {
      decodedData = response.body;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return HttpResponseData(
        data: decodedData,
        statusCode: response.statusCode,
        headers: response.headers,
      );
    } else {
      final message = HttpExceptionHandler.handle(response.statusCode, response.body);
      throw HttpException(message, response.statusCode);
    }
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final response = await _client.get(
        uri,
        headers: _defaultHeaders(headers),
      );
      return _processResponse(response);
    } on SocketException {
      throw const HttpException('No internet connection. Please check your network.');
    } catch (e) {
      if (e is HttpException) rethrow;
      throw HttpException('Failed to complete request: $e');
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
      final uri = _buildUri(url, queryParameters);
      final response = await _client.post(
        uri,
        headers: _defaultHeaders(headers),
        body: body is String ? body : (body != null ? jsonEncode(body) : null),
      );
      return _processResponse(response);
    } on SocketException {
      throw const HttpException('No internet connection. Please check your network.');
    } catch (e) {
      if (e is HttpException) rethrow;
      throw HttpException('Failed to complete request: $e');
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
      final uri = _buildUri(url, queryParameters);
      final response = await _client.put(
        uri,
        headers: _defaultHeaders(headers),
        body: body is String ? body : (body != null ? jsonEncode(body) : null),
      );
      return _processResponse(response);
    } on SocketException {
      throw const HttpException('No internet connection. Please check your network.');
    } catch (e) {
      if (e is HttpException) rethrow;
      throw HttpException('Failed to complete request: $e');
    }
  }

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final response = await _client.delete(
        uri,
        headers: _defaultHeaders(headers),
      );
      return _processResponse(response);
    } on SocketException {
      throw const HttpException('No internet connection. Please check your network.');
    } catch (e) {
      if (e is HttpException) rethrow;
      throw HttpException('Failed to complete request: $e');
    }
  }
}
