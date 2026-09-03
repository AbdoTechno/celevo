import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/models/person_images_model.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/persons/view/image_viewer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonPhotoGallery extends StatelessWidget {
  final PersonModel personModel;
  final PersonImagesModel? images;

  const PersonPhotoGallery({
    super.key,
    required this.personModel,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    final profiles = images?.profiles;

    if (profiles == null || profiles.isEmpty) {
      if (personModel.profilePath != null) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageViewerView(
                  imageUrl: 'https://image.tmdb.org/t/p/original${personModel.profilePath}',
                  title: personModel.name,
                  subtitle: personModel.knownForDepartment,
                ),
              ),
            );
          },
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: AppColors.darkBorder.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${personModel.profilePath}',
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.45),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.zoom_in, color: AppColors.primary, size: 16.sp),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'View High-Res Photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: AppColors.darkBorder.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            'No additional portrait photos available.',
            style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 13.sp),
          ),
        ),
      );
    }

    return SizedBox(
      height: 185.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: profiles.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final fullImageUrl = 'https://image.tmdb.org/t/p/original${profile.filePath}';
          final thumbUrl = 'https://image.tmdb.org/t/p/w342${profile.filePath}';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewerView(
                    imageUrl: fullImageUrl,
                    title: personModel.name,
                    subtitle: 'Photo ${index + 1} of ${profiles.length}',
                  ),
                ),
              );
            },
            child: Container(
              width: 125.w,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: AppColors.darkBorder.withValues(alpha: 0.8),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: thumbUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.darkSurface,
                        child: Center(
                          child: SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.darkSurface,
                        child: const Icon(CupertinoIcons.photo, color: AppColors.textMutedDark),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.65),
                            ],
                            stops: const [0.65, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.h,
                      right: 8.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              CupertinoIcons.zoom_in,
                              color: Colors.white,
                              size: 13.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
