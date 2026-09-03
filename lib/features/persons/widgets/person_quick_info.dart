import 'package:celevo/core/models/person_details_model.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonQuickInfo extends StatelessWidget {
  final PersonModel personModel;
  final PersonDetailsModel? details;

  const PersonQuickInfo({
    super.key,
    required this.personModel,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: CupertinoIcons.person_crop_circle_fill,
            label: 'GENDER',
            value: _getGender(details?.gender ?? personModel.gender),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildStatCard(
            icon: CupertinoIcons.film,
            label: 'DEPARTMENT',
            value: details?.knownForDepartment ?? personModel.knownForDepartment ?? 'N/A',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildStatCard(
            icon: CupertinoIcons.chart_bar_alt_fill,
            label: 'POPULARITY',
            value: (details?.popularity ?? personModel.popularity)?.toStringAsFixed(1) ?? 'N/A',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.darkBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: AppColors.primary,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textMutedDark,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _getGender(int? gender) {
    if (gender == 1) return 'Female';
    if (gender == 2) return 'Male';
    return 'N/A';
  }
}
