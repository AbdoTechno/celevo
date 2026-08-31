import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/persons/widgets/image_viewer_controls.dart';
import 'package:celevo/features/persons/widgets/image_viewer_info_overlay.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerView extends StatefulWidget {
  final String imageUrl;
  final String? title;
  final String? subtitle;

  const ImageViewerView({
    super.key,
    required this.imageUrl,
    this.title,
    this.subtitle,
  });

  @override
  State<ImageViewerView> createState() => _ImageViewerViewState();
}

class _ImageViewerViewState extends State<ImageViewerView> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  Future<void> _downloadImage() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = 'celevo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savePath = '${tempDir.path}/$fileName';

      final dio = Dio();
      await dio.download(
        widget.imageUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total > 0 && mounted) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
      }

      await Gal.putImage(savePath);

      final file = File(savePath);
      if (await file.exists()) {
        await file.delete();
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          content: Row(
            children: [
              const Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.white),
              SizedBox(width: 10.w),
              const Expanded(
                child: Text(
                  'Image saved to your gallery successfully!',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          content: Row(
            children: [
              const Icon(CupertinoIcons.exclamationmark_circle_fill, color: Colors.white),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Failed to download image: $e',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // PhotoView for high-res zoom & pan
          PhotoView(
            imageProvider: CachedNetworkImageProvider(widget.imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3.5,
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: widget.imageUrl),
            loadingBuilder: (context, event) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      value: event == null || event.expectedTotalBytes == null
                          ? null
                          : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                      color: AppColors.primary,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading high-res image...',
                      style: TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.exclamationmark_triangle, color: AppColors.error, size: 48.sp),
                    SizedBox(height: 12.h),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            },
          ),

          // Top Controls (Close & Download)
          ImageViewerControls(
            isDownloading: _isDownloading,
            onDownload: _downloadImage,
            onClose: () => Navigator.pop(context),
          ),

          // Bottom Info Overlay
          ImageViewerInfoOverlay(
            title: widget.title,
            subtitle: widget.subtitle,
            isDownloading: _isDownloading,
            downloadProgress: _downloadProgress,
          ),
        ],
      ),
    );
  }
}
