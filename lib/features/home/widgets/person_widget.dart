import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/favorites/cubit/favorites_cubit.dart';
import 'package:celevo/features/favorites/cubit/favorites_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({super.key, required this.person});

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Profile Image with caching
          person.profilePath != null
              ? CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${person.profilePath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.darkSurface,
                    child: Center(
                      child: SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return _buildPlaceholder();
                  },
                )
              : _buildPlaceholder(),

          /// Gradient for text contrast
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.9),
                  ],
                  stops: const [0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),

          /// Favorite button
          Positioned(
            top: 10.h,
            right: 10.w,
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFav = (state is FavoritesLoaded) && state.isFavorite(person.id);

                return _FavoriteIconButton(
                  isFav: isFav,
                  onTap: () {
                    context.read<FavoritesCubit>().toggleFavorite(person);
                  },
                );
              },
            ),
          ),

          /// Person information
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
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  person.knownForDepartment ?? 'Celebrity',
                  style: TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.darkSurface,
      child: Center(
        child: Icon(
          CupertinoIcons.person_fill,
          size: 36.sp,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }
}

class _FavoriteIconButton extends StatelessWidget {
  final bool isFav;
  final VoidCallback onTap;

  const _FavoriteIconButton({
    required this.isFav,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: isFav
                ? AppColors.favorite
                : Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            size: 18.sp,
            color: isFav ? AppColors.favorite : Colors.white,
          ),
        ),
      ),
    );
  }
}
