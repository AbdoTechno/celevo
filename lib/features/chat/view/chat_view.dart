import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/chat/cubit/chat_cubit.dart';
import 'package:celevo/features/chat/cubit/chat_state.dart';
import 'package:celevo/features/chat/widgets/chat_input_bar.dart';
import 'package:celevo/features/chat/widgets/chat_loading_bubble.dart';
import 'package:celevo/features/chat/widgets/chat_message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends StatefulWidget {
  final bool isTab;

  const ChatView({super.key, this.isTab = false});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasText = false;

  static const List<String> _suggestedPrompts = [
    'Recommend top movies directed by Christopher Nolan',
    'Tell me about Pedro Pascal\'s career and awards',
    'Who won Best Actor at recent Academy Awards?',
    'Top must-watch psychological thriller films',
  ];

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

  void _sendMessage([String? customText]) {
    final text = (customText ?? _controller.text).trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(text);
    if (customText == null) {
      _controller.clear();
    }
    _scrollToBottom();
  }

  void _confirmClearChat() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Clear Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Are you sure you want to clear this conversation?',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textMutedDark)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ChatCubit>().clearChat();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: (!widget.isTab && Navigator.canPop(context))
            ? IconButton(
                icon: const Icon(CupertinoIcons.chevron_left),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text(
          'AI Assistant',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 18.sp,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.trash),
            tooltip: 'Clear Chat',
            onPressed: _confirmClearChat,
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

                  if (messages.isEmpty && !state.isGenerating) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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

            // Input Bar directly on top of the bottom navigation bar with zero overlap
            ChatInputBar(
              controller: _controller,
              hasText: _hasText,
              onSendMessage: () => _sendMessage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Icon(
            CupertinoIcons.chat_bubble_2,
            size: 44.sp,
            color: AppColors.textMutedDark,
          ),
          SizedBox(height: 14.h),
          Text(
            'Film & Celebrity Guide',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Ask any question about actors, directors, and movies, or pick a suggestion below:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20.h),
          ..._suggestedPrompts.map(
            (prompt) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: InkWell(
                onTap: () => _sendMessage(prompt),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          prompt,
                          style: TextStyle(
                            color: AppColors.textPrimaryDark,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.arrow_up_right,
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
