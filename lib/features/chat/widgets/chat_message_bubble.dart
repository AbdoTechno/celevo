import 'package:celevo/core/models/chat_message_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final VoidCallback? onRetry;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        child: GestureDetector(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: message.text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Message copied'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isUser
                  ? AppColors.primary
                  : message.isError
                      ? AppColors.error.withValues(alpha: 0.15)
                      : AppColors.darkCard,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 18),
              ),
              border: Border.all(
                color: isUser
                    ? AppColors.primary
                    : message.isError
                        ? AppColors.error.withValues(alpha: 0.4)
                        : AppColors.darkBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: isUser ? Colors.black : Colors.white,
                    fontSize: 14.5,
                    height: 1.4,
                    fontWeight: isUser ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
                if (message.isError && onRetry != null) ...[
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: onRetry,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.arrow_clockwise, size: 13, color: AppColors.error),
                        SizedBox(width: 4),
                        Text(
                          'Retry',
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
