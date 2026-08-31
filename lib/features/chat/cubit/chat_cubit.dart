import 'package:celevo/core/models/chat_message_model.dart';
import 'package:celevo/core/repos/ai_chat_repo.dart';
import 'package:celevo/features/chat/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final AiChatRepo _repo;

  ChatCubit(this._repo)
      : super(
          ChatUpdated(
            messages: [
              ChatMessageModel(
                id: 'welcome_1',
                text: 'Hello! How can I help you today with movies or actors?',
                isUser: false,
                timestamp: DateTime.now(),
              ),
            ],
          ),
        );

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final currentMessages = (state is ChatUpdated) ? (state as ChatUpdated).messages : <ChatMessageModel>[];

    final userMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: trimmed,
      isUser: true,
      timestamp: DateTime.now(),
    );

    final updatedWithUser = [...currentMessages, userMessage];

    emit(ChatUpdated(
      messages: updatedWithUser,
      isGenerating: true,
      errorMessage: null,
    ));

    try {
      final responseText = await _repo.sendMessage(trimmed);

      final aiMessage = ChatMessageModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: responseText,
        isUser: false,
        timestamp: DateTime.now(),
      );

      emit(ChatUpdated(
        messages: [...updatedWithUser, aiMessage],
        isGenerating: false,
      ));
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      final errorAiMessage = ChatMessageModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: 'Sorry, I encountered an issue: $errorMsg',
        isUser: false,
        timestamp: DateTime.now(),
        isError: true,
      );

      emit(ChatUpdated(
        messages: [...updatedWithUser, errorAiMessage],
        isGenerating: false,
        errorMessage: errorMsg,
      ));
    }
  }

  void clearChat() {
    emit(
      ChatUpdated(
        messages: [
          ChatMessageModel(
            id: 'welcome_1',
            text: 'Hello! How can I help you today with movies or actors?',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
