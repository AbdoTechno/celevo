import 'package:celevo/core/constants/api_constants.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_exception.dart';
import 'package:dio/dio.dart';

class PopularPersonRepo {
  final BaseApiService _apiService;

  PopularPersonRepo({required this._apiService});

  Future<PopularPersonModel> getPopularPersons({
    int page = 1,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConstants.popularPersons,
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'page': page,
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      return PopularPersonModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      DioExceptionHandler.handle(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to get popular persons: $e');
    }
  }
}
