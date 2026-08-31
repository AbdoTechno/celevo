import 'package:celevo/core/constants/api_constants.dart';
import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_exception.dart';
import 'package:dio/dio.dart';

class AiChatRepo {
  final BaseApiService apiService;

  AiChatRepo({required this.apiService});

  Future<String> sendMessage(String message) async {
    final apiKey = ApiConstants.geminiApiKey.trim();

    if (apiKey.isEmpty) {
      return 'Please add your Google Gemini API key in lib/core/constants/api_constants.dart to enable live AI chat.';
    }

    try {
      final response = await apiService.post(
        ApiConstants.geminiChatUrl(apiKey),
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          'contents': [
            {
              'parts': [
                {'text': message},
              ],
            },
          ],
        },
      );

      final dynamic data = response.data;
      if (data is Map<String, dynamic>) {
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content?['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] as String;
          }
        }
      }

      return 'No response generated from the AI model.';
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to get response: $e');
    }
  }
}
