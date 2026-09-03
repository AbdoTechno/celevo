import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/favorites/cubit/favorites_cubit.dart';
import 'package:celevo/features/favorites/cubit/favorites_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonHeroAppBar extends StatelessWidget {
  final PersonModel personModel;

  const PersonHeroAppBar({
    super.key,
    required this.personModel,
  });

  @override
  Widget build(BuildContext context) {
    final String name = personModel.name ?? 'Unknown';
    final String department = personModel.knownForDepartment ?? 'Actor';

    return SliverAppBar(
      expandedHeight: 440.h,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.darkBackground,
      leading: Padding(
        padding: EdgeInsets.only(left: 14.w),
        child: Center(
          child: _buildCircleButton(
            icon: CupertinoIcons.chevron_left,
            iconColor: Colors.white,
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 14.w),
          child: Center(
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, favState) {
                final isFav = (favState is FavoritesLoaded) && favState.isFavorite(personModel.id);
                return _buildCircleButton(
                  icon: isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  iconColor: isFav ? AppColors.favorite : Colors.white,
                  isFav: isFav,
                  onTap: () {
                    context.read<FavoritesCubit>().toggleFavorite(personModel);
                  },
                );
              },
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            // HERO IMAGE
            Hero(
              tag: 'person_${personModel.id}',
              child: personModel.profilePath != null
                  ? CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w780${personModel.profilePath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),

            // GRADIENT OVERLAY
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                      AppColors.darkBackground,
                    ],
                    stops: const [0.0, 0.25, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            // BOTTOM HEADER CONTENT
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Department badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      department.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Name
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  if (personModel.popularity != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      '${personModel.popularity!.toStringAsFixed(1)} popularity',
                      style: TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    bool isFav = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: isFav
                ? AppColors.favorite
                : Colors.white.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 18.sp,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.darkSurface,
      child: Center(
        child: Icon(
          CupertinoIcons.person,
          size: 48.sp,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }
}
