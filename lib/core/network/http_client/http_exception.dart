class HttpException implements Exception {
  final String message;
  final int? statusCode;

  const HttpException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class HttpExceptionHandler {
  static String handle(int statusCode, [String? body]) {
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
        return 'Server error ($statusCode).';
    }
  }
}
