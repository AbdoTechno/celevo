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
      height: 235.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: knownFor.length,
        separatorBuilder: (_, _) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          final known = knownFor[index];
          final String title = known.title ?? known.name ?? 'Unknown Title';
          final String? poster = known.posterPath;
          final year = _extractYear(known.releaseDate ?? known.firstAirDate);

          return SizedBox(
            width: 135.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.darkBorder,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: poster != null
                          ? CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w342$poster',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => _buildPosterPlaceholder(),
                              errorWidget: (context, url, error) => _buildPosterPlaceholder(),
                            )
                          : _buildPosterPlaceholder(),
                    ),

                    // Title & Year info
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (year.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Text(
                              year,
                              style: TextStyle(
                                color: AppColors.textMutedDark,
                                fontSize: 11.sp,
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

  String _extractYear(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      return date.split('-').first;
    } catch (_) {
      return '';
    }
  }
}
