class ApiConstants {
  static const String baseUrl =
      'https://api.themoviedb.org/3';

  static const String apiKey = '2dfe23358236069710a379edd4c65a6b';
  static const String popularPersons = '/person/popular';

  static String personDetails(int id) => '/person/$id';

  static String personImages(int id) =>
      '/person/$id/images';
}
