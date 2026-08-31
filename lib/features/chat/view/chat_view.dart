import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/chat/cubit/chat_cubit.dart';
import 'package:celevo/features/chat/cubit/chat_state.dart';
import 'package:celevo/features/chat/widgets/chat_input_bar.dart';
import 'package:celevo/features/chat/widgets/chat_loading_bubble.dart';
import 'package:celevo/features/chat/widgets/chat_message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chat Bot',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.trash),
            tooltip: 'Clear Chat',
            onPressed: () {
              context.read<ChatCubit>().clearChat();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Messages List
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  _scrollToBottom();
                },
                builder: (context, state) {
                  if (state is! ChatUpdated) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  final messages = state.messages;

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    itemCount: messages.length + (state.isGenerating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == messages.length && state.isGenerating) {
                        return const ChatLoadingBubble();
                      }

                      final message = messages[index];
                      return ChatMessageBubble(
                        message: message,
                        onRetry: message.isError
                            ? () => context.read<ChatCubit>().sendMessage(message.text)
                            : null,
                      );
                    },
                  );
                },
              ),
            ),

            // Input Bar
            ChatInputBar(
              controller: _controller,
              hasText: _hasText,
              onSendMessage: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
