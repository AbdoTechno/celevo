class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // TMDb API Key
  static const String apiKey = '2dfe23358236069710a379edd4c65a6b';

  // Google Gemini API Key
  static const String geminiApiKey = '';

  // Endpoints
  static const String popularPersons = '/person/popular';
  static String personDetails(int id) => '/person/$id';
  static String personImages(int id) => '/person/$id/images';

  static String geminiChatUrl(String key) =>
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$key';
}
