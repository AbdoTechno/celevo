import 'package:celevo/core/constants/api_constants.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_exception.dart';
import 'package:dio/dio.dart';

class PopularPersonRepo {
  final BaseApiService apiService;

  PopularPersonRepo({required this.apiService});

  Future<PopularPersonModel> getPopularPersons({
    int page = 2,
  }) async {
    try {
      final response = await apiService.get(
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

      final dynamic data = response.data;
      if (data is Map<String, dynamic>) {
        return PopularPersonModel.fromJson(data);
      }
      throw Exception('Invalid response format');
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to get popular persons: $e');
    }
  }
}
