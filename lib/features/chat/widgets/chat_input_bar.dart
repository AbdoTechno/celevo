import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/chat/cubit/chat_cubit.dart';
import 'package:celevo/features/chat/cubit/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool hasText;
  final VoidCallback onSendMessage;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.hasText,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        border: Border(
          top: BorderSide(color: AppColors.darkBorder, width: 0.8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text Field
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 44,
                maxHeight: 120,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                ),
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    color: AppColors.textMutedDark,
                    fontSize: 14.0,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8.0),

          // Send Button
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final isGenerating = (state is ChatUpdated) && state.isGenerating;

              return Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (hasText && !isGenerating)
                      ? AppColors.primary
                      : AppColors.darkCard,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: (hasText && !isGenerating)
                        ? AppColors.primary
                        : AppColors.darkBorder,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: isGenerating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        )
                      : Icon(
                          CupertinoIcons.arrow_up,
                          size: 20,
                          color: hasText ? Colors.black : AppColors.textMutedDark,
                        ),
                  onPressed: (hasText && !isGenerating) ? onSendMessage : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
