import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/favorites/cubit/favorites_cubit.dart';
import 'package:celevo/features/persons/view/person_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritePersonCard extends StatelessWidget {
  final PersonModel person;

  const FavoritePersonCard({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonView(personModel: person),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.darkBorder.withValues(alpha: 0.7),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              if (person.profilePath != null)
                CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${person.profilePath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.darkSurface,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.darkSurface,
                    child: const Icon(CupertinoIcons.person_fill, color: AppColors.textMutedDark),
                  ),
                )
              else
                Container(
                  color: AppColors.darkSurface,
                  child: const Icon(CupertinoIcons.person_fill, color: AppColors.textMutedDark),
                ),

              // Gradient
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.9),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),

              // Remove favorite button
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.favorite.withValues(alpha: 0.5),
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      CupertinoIcons.heart_fill,
                      color: AppColors.favorite,
                      size: 18,
                    ),
                    onPressed: () {
                      if (person.id != null) {
                        context.read<FavoritesCubit>().removeFavorite(person.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.darkCard,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            duration: const Duration(seconds: 2),
                            content: Text(
                              '${person.name ?? "Person"} removed from favorites',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),

              // Name & Department
              Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      person.name ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            person.knownForDepartment ?? 'Celebrity',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
