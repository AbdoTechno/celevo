import 'package:celevo/core/models/person_details_model.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: CupertinoIcons.person_fill,
              title: 'Gender',
              value: _getGender(details?.gender ?? personModel.gender),
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatItem(
              icon: CupertinoIcons.briefcase_fill,
              title: 'Department',
              value: details?.knownForDepartment ?? personModel.knownForDepartment ?? 'N/A',
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatItem(
              icon: CupertinoIcons.chart_bar_fill,
              title: 'Popularity',
              value: (details?.popularity ?? personModel.popularity)?.toStringAsFixed(1) ?? 'N/A',
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
          Icon(
            icon,
            size: 20.sp,
            color: AppColors.primary,
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textMutedDark,
              fontSize: 11.sp,
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
      height: 40.h,
      color: AppColors.darkBorder.withValues(alpha: 0.65),
    );
  }

  String _getGender(int? gender) {
    if (gender == 1) return 'Female';
    if (gender == 2) return 'Male';
    return 'N/A';
  }
}
