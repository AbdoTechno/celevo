import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key, required this.personModel});

  final PersonModel personModel;

  @override
  Widget build(BuildContext context) {
    final String name = personModel.name ?? 'Unknown';
    final String department =
        personModel.knownForDepartment ?? 'Actor';

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ============================================================
          // HERO
          // ============================================================
          SliverAppBar(
            expandedHeight: 430.h,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.darkBackground,
            leadingWidth: 64.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: _CircleButton(
                icon: CupertinoIcons.chevron_left,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _CircleButton(
                  icon: CupertinoIcons.heart,
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // ------------------------------------------------------
                  // IMAGE
                  // ------------------------------------------------------
                  Hero(
                    tag: 'person_${personModel.id}',
                    child: personModel.profilePath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w780${personModel.profilePath}',
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) {
                              return _buildImagePlaceholder();
                            },
                          )
                        : _buildImagePlaceholder(),
                  ),

                  // ------------------------------------------------------
                  // TOP DARK GRADIENT
                  // ------------------------------------------------------
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.55),
                            Colors.transparent,
                            AppColors.darkBackground
                                .withValues(alpha: 0.25),
                            AppColors.darkBackground,
                          ],
                          stops: const [
                            0.0,
                            0.35,
                            0.68,
                            1.0,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ------------------------------------------------------
                  // BOTTOM CONTENT
                  // ------------------------------------------------------
                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: 28.h,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // Department badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary
                                .withValues(alpha: 0.92),
                            borderRadius:
                                BorderRadius.circular(20.r),
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

                        // Name
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            height: 1.05,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black
                                    .withValues(alpha: 0.7),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Popularity
                        if (personModel.popularity != null)
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .chart_bar_alt_fill,
                                color: AppColors.primary,
                                size: 14.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '${personModel.popularity!.toStringAsFixed(1)} popularity',
                                style: TextStyle(
                                  color: Colors.white
                                      .withValues(alpha: 0.78),
                                  fontSize: 12.sp,
                                  fontWeight:
                                      FontWeight.w500,
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

          // ============================================================
          // BODY
          // ============================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20.w,
                8.h,
                20.w,
                30.h,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------------
                  // QUICK INFO
                  // ------------------------------------------------------
                  _buildQuickInfo(),

                  SizedBox(height: 28.h),

                  // ------------------------------------------------------
                  // BIOGRAPHY
                  // ------------------------------------------------------
                  _buildSectionHeader(
                    title: 'Biography',
                    icon: CupertinoIcons.doc_text,
                  ),

                  SizedBox(height: 12.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(
                        18.r,
                      ),
                      border: Border.all(
                        color: AppColors.darkBorder
                            .withValues(alpha: 0.65),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.18,
                          ),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      'No biography available for this person yet.',
                      style: TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 14.sp,
                        height: 1.65,
                      ),
                    ),
                  ),

                  // ------------------------------------------------------
                  // KNOWN FOR
                  // ------------------------------------------------------
                  if (personModel.knownFor != null &&
                      personModel.knownFor!.isNotEmpty) ...[
                    SizedBox(height: 30.h),

                    _buildSectionHeader(
                      title: 'Known For',
                      icon: CupertinoIcons.film,
                    ),

                    SizedBox(height: 14.h),

                    SizedBox(
                      height: 230.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics:
                            const BouncingScrollPhysics(),
                        itemCount:
                            personModel.knownFor!.length,
                        separatorBuilder: (_, _) =>
                            SizedBox(width: 14.w),
                        itemBuilder: (context, index) {
                          final known =
                              personModel.knownFor![index];

                          return _buildKnownForItem(known);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================================
  // QUICK INFO
  // ======================================================================

  Widget _buildQuickInfo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: CupertinoIcons.person_fill,
              title: 'Gender',
              value: _getGender(personModel.gender),
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatItem(
              icon: CupertinoIcons.briefcase_fill,
              title: 'Department',
              value:
                  personModel.knownForDepartment ?? 'N/A',
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatItem(
              icon: CupertinoIcons.chart_bar_fill,
              title: 'Popularity',
              value:
                  personModel.popularity?.toStringAsFixed(
                    1,
                  ) ??
                  'N/A',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.12),
            ),
            child: Icon(
              icon,
              size: 17.sp,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            title,
            style: TextStyle(
              color: AppColors.textMutedDark,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 3.h),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 48.h,
      color: AppColors.darkBorder.withValues(alpha: 0.65),
    );
  }

  // ======================================================================
  // SECTION HEADER
  // ======================================================================

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 34.w,
          height: 34.w,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            size: 17.sp,
            color: AppColors.primary,
          ),
        ),

        SizedBox(width: 10.w),

        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 19.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  // ======================================================================
  // KNOWN FOR
  // ======================================================================

  Widget _buildKnownForItem(KnownFor known) {
    final String title =
        known.title ?? known.name ?? 'Unknown';

    final String? poster = known.posterPath;

    return SizedBox(
      width: 145.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: AppColors.darkBorder.withValues(alpha: 0.65),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------------------
              // POSTER
              // ----------------------------------------------------------
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    poster != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w300$poster',
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) {
                              return _buildPosterPlaceholder();
                            },
                          )
                        : _buildPosterPlaceholder(),

                    // Poster gradient
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(
                                alpha: 0.55,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ----------------------------------------------------------
              // TITLE
              // ----------------------------------------------------------
              Padding(
                padding: EdgeInsets.fromLTRB(
                  12.w,
                  10.h,
                  12.w,
                  12.h,
                ),
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
  }

  // ======================================================================
  // IMAGE PLACEHOLDERS
  // ======================================================================

  Widget _buildImagePlaceholder() {
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

  Widget _buildPosterPlaceholder() {
    return Container(
      color: AppColors.darkSurface,
      child: Center(
        child: Icon(
          CupertinoIcons.film,
          size: 32.sp,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }

  // ======================================================================
  // GENDER
  // ======================================================================

  String _getGender(int? gender) {
    if (gender == 1) return 'Female';
    if (gender == 2) return 'Male';
    return 'N/A';
  }
}

// ========================================================================
// CIRCLE BUTTON
// ========================================================================

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, size: 19.sp, color: Colors.white),
      ),
    );
  }
}
