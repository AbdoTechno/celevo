import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again.';

      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server response timeout. Please try again.';

      case DioExceptionType.badCertificate:
        return 'Secure connection could not be established.';

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.unknown:
        return 'Something went wrong. Please try again.';
      case DioExceptionType.transformTimeout:
        return 'Request timeout. Please try again.';
    }
  }

  static String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your request.';

      case 401:
        return 'Unauthorized request.';

      case 403:
        return 'You do not have permission to access this resource.';

      case 404:
        return 'The requested resource was not found.';

      case 429:
        return 'Too many requests. Please try again later.';

      case 500:
        return 'Internal server error.';

      case 502:
      case 503:
      case 504:
        return 'Server is currently unavailable.';

      default:
        return 'Server error${statusCode != null ? ' ($statusCode)' : ''}.';
    }
  }
}
