import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatLoadingBubble extends StatelessWidget {
  const ChatLoadingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Thinking...',
              style: TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
