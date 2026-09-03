import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/chat/cubit/chat_cubit.dart';
import 'package:celevo/features/chat/cubit/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        border: Border(
          top: BorderSide(
            color: AppColors.darkBorder.withValues(alpha: 0.8),
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text Field Container
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 44.h,
                maxHeight: 110.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: hasText
                      ? AppColors.primary.withValues(alpha: 0.5)
                      : AppColors.darkBorder,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Ask about actors, movies, directors...',
                  hintStyle: TextStyle(
                    color: AppColors.textMutedDark,
                    fontSize: 13.sp,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // Send Button
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final isGenerating = (state is ChatUpdated) && state.isGenerating;
              final canSend = hasText && !isGenerating;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: canSend ? AppColors.primary : AppColors.darkCard,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: canSend ? AppColors.primary : AppColors.darkBorder,
                    width: 1,
                  ),
                  boxShadow: canSend
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: isGenerating
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        )
                      : Icon(
                          CupertinoIcons.arrow_up,
                          size: 19.sp,
                          color: canSend ? Colors.black : AppColors.textMutedDark,
                        ),
                  onPressed: canSend ? onSendMessage : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
