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
              border: Border.all(color: AppColors.darkBorder),
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
                      color: Colors.black.withValues(alpha: 0.3),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(CupertinoIcons.zoom_in, color: Colors.white),
                            SizedBox(width: 8.w),
                            Text(
                              'Tap to view in Fullscreen & Download',
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
                ],
              ),
            ),
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Center(
          child: Text(
            'No photos available for this person.',
            style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 13.sp),
          ),
        ),
      );
    }

    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: profiles.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final fullImageUrl = 'https://image.tmdb.org/t/p/original${profile.filePath}';
          final thumbUrl = 'https://image.tmdb.org/t/p/w300${profile.filePath}';

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
                border: Border.all(color: AppColors.darkBorder),
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
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
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
                              Colors.black.withValues(alpha: 0.7),
                            ],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          CupertinoIcons.zoom_in,
                          color: Colors.white,
                          size: 14.sp,
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
