import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageViewerControls extends StatelessWidget {
  final bool isDownloading;
  final VoidCallback onDownload;
  final VoidCallback onClose;

  const ImageViewerControls({
    super.key,
    required this.isDownloading,
    required this.onDownload,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button
          _ViewerCircleButton(
            icon: CupertinoIcons.xmark,
            tooltip: 'Close',
            onPressed: onClose,
          ),

          // Download button
          _ViewerCircleButton(
            icon: isDownloading
                ? CupertinoIcons.arrow_2_circlepath
                : CupertinoIcons.arrow_down_to_line,
            tooltip: 'Download to Gallery',
            isLoading: isDownloading,
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }
}

class _ViewerCircleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isLoading;

  const _ViewerCircleButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
          ),
        ],
      ),
      child: IconButton(
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        icon: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : Icon(icon, size: 20.sp, color: Colors.white),
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}
