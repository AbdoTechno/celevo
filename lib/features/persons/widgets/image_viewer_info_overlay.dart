import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageViewerInfoOverlay extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool isDownloading;
  final double downloadProgress;

  const ImageViewerInfoOverlay({
    super.key,
    this.title,
    this.subtitle,
    required this.isDownloading,
    required this.downloadProgress,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null && subtitle == null && !isDownloading) {
      return const SizedBox.shrink();
    }

    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: MediaQuery.of(context).padding.bottom + 20.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDownloading) ...[
              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Downloading ${(downloadProgress * 100).toInt()}%...',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: downloadProgress,
                  backgroundColor: Colors.white12,
                  color: AppColors.primary,
                  minHeight: 4.h,
                ),
              ),
            ] else ...[
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
