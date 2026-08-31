import 'package:celevo/core/constants/api_constants.dart';
import 'package:celevo/core/models/person_details_model.dart';
import 'package:celevo/core/models/person_images_model.dart';
import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_exception.dart';
import 'package:dio/dio.dart';

class PersonDetailsRepo {
  final BaseApiService apiService;

  PersonDetailsRepo({required this.apiService});

  Future<PersonDetailsModel> getPersonDetails(int id) async {
    try {
      final response = await apiService.get(
        ApiConstants.personDetails(id),
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final dynamic data = response.data;
      if (data is Map<String, dynamic>) {
        return PersonDetailsModel.fromJson(data);
      }
      throw Exception('Invalid response format');
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to get person details: $e');
    }
  }

  Future<PersonImagesModel> getPersonImages(int id) async {
    try {
      final response = await apiService.get(
        ApiConstants.personImages(id),
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final dynamic data = response.data;
      if (data is Map<String, dynamic>) {
        return PersonImagesModel.fromJson(data);
      }
      throw Exception('Invalid response format');
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to get person images: $e');
    }
  }
}
