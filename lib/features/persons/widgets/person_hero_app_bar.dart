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
      expandedHeight: 430.h,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.darkBackground,
      leading: IconButton(
        icon: const Icon(CupertinoIcons.chevron_left, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, favState) {
            final isFav = (favState is FavoritesLoaded) && favState.isFavorite(personModel.id);
            return IconButton(
              icon: Icon(
                isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: isFav ? AppColors.favorite : Colors.white,
              ),
              onPressed: () {
                context.read<FavoritesCubit>().toggleFavorite(personModel);
              },
            );
          },
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

            // TOP & BOTTOM GRADIENTS
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.55),
                      Colors.transparent,
                      AppColors.darkBackground.withValues(alpha: 0.35),
                      AppColors.darkBackground,
                    ],
                    stops: const [0.0, 0.35, 0.68, 1.0],
                  ),
                ),
              ),
            ),

            // BOTTOM HEADER CONTENT
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 24.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      department,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      height: 1.1,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.8),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (personModel.popularity != null)
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.chart_bar_alt_fill,
                          color: AppColors.primary,
                          size: 14.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${personModel.popularity!.toStringAsFixed(1)} popularity',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.darkSurface,
      child: Center(
        child: Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.10),
          ),
          child: Icon(
            CupertinoIcons.person,
            size: 42.sp,
            color: AppColors.textMutedDark,
          ),
        ),
      ),
    );
  }
}
