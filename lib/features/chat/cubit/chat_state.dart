import 'package:celevo/core/models/chat_message_model.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatUpdated extends ChatState {
  final List<ChatMessageModel> messages;
  final bool isGenerating;
  final String? errorMessage;

  const ChatUpdated({
    required this.messages,
    this.isGenerating = false,
    this.errorMessage,
  });

  ChatUpdated copyWith({
    List<ChatMessageModel>? messages,
    bool? isGenerating,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatUpdated(
      messages: messages ?? this.messages,
      isGenerating: isGenerating ?? this.isGenerating,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
