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
      dynamic response = await _callGemini(apiKey, model: 'gemini-3.6-flash', message: message);

      var data = response?.data;
      if (data is Map<String, dynamic> && data['error'] != null) {
        // Try fallback to gemini-3.5-flash-lite
        response = await _callGemini(apiKey, model: 'gemini-3.5-flash-lite', message: message);
        data = response?.data;
      }

      if (data is Map<String, dynamic>) {
        if (data['error'] != null) {
          final err = data['error'];
          final msg = err is Map ? err['message'] : err.toString();
          throw Exception(msg);
        }

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

  Future<dynamic> _callGemini(String apiKey, {required String model, required String message}) {
    return apiService.post(
      ApiConstants.geminiChatUrl(apiKey, model: model),
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
  }
}
