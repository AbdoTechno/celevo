import 'package:celevo/core/models/person_details_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonPersonalDetailsCard extends StatelessWidget {
  final PersonDetailsModel details;

  const PersonPersonalDetailsCard({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    if (details.birthday == null && details.placeOfBirth == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.darkBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (details.birthday != null)
            _buildDetailRow(
              icon: CupertinoIcons.calendar,
              label: 'Born',
              value: details.deathday != null
                  ? '${details.birthday}  •  Died: ${details.deathday}'
                  : '${details.birthday}  (${_calculateAge(details.birthday)} years old)',
            ),
          if (details.birthday != null && details.placeOfBirth != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Divider(
                height: 1,
                color: AppColors.darkBorder.withValues(alpha: 0.6),
              ),
            ),
          if (details.placeOfBirth != null)
            _buildDetailRow(
              icon: CupertinoIcons.placemark_fill,
              label: 'Origin',
              value: details.placeOfBirth!,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: AppColors.primary),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: AppColors.textMutedDark,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _calculateAge(String? birthday) {
    if (birthday == null) return '';
    try {
      final parts = birthday.split('-');
      if (parts.isNotEmpty) {
        final birthYear = int.tryParse(parts[0]);
        if (birthYear != null) {
          final nowYear = DateTime.now().year;
          return '${nowYear - birthYear}';
        }
      }
    } catch (_) {}
    return '';
  }
}
