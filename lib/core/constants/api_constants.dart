import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // TMDb API Key
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  // Google Gemini API Key
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  // Endpoints
  static const String popularPersons = '/person/popular';
  static String personDetails(int id) => '/person/$id';
  static String personImages(int id) => '/person/$id/images';

  static String geminiChatUrl(String key, {String model = 'gemini-3.6-flash'}) =>
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$key';
}
