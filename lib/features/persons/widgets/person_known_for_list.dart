import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonKnownForList extends StatelessWidget {
  final List<KnownFor> knownFor;

  const PersonKnownForList({
    super.key,
    required this.knownFor,
  });

  @override
  Widget build(BuildContext context) {
    if (knownFor.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 230.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: knownFor.length,
        separatorBuilder: (_, _) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          final known = knownFor[index];
          final String title = known.title ?? known.name ?? 'Unknown';
          final String? poster = known.posterPath;

          return SizedBox(
            width: 145.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          poster != null
                              ? CachedNetworkImage(
                                  imageUrl: 'https://image.tmdb.org/t/p/w300$poster',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => _buildPosterPlaceholder(),
                                  errorWidget: (context, url, error) => _buildPosterPlaceholder(),
                                )
                              : _buildPosterPlaceholder(),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.55),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textPrimaryDark,
                          fontSize: 12.sp,
                          height: 1.25,
                          fontWeight: FontWeight.w600,
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

  Widget _buildPosterPlaceholder() {
    return Container(
      color: AppColors.darkSurface,
      child: const Center(
        child: Icon(
          CupertinoIcons.film,
          size: 32,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }
}
