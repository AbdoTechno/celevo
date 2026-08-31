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
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.darkBorder.withValues(alpha: 0.7)),
      ),
      child: Column(
        children: [
          if (details.birthday != null)
            _buildDetailRow(
              icon: CupertinoIcons.calendar,
              label: 'Birthday',
              value: details.deathday != null
                  ? '${details.birthday} - ${details.deathday}'
                  : '${details.birthday} (${_calculateAge(details.birthday)} years old)',
            ),
          if (details.birthday != null && details.placeOfBirth != null)
            Divider(height: 16.h, color: AppColors.darkBorder.withValues(alpha: 0.5)),
          if (details.placeOfBirth != null)
            _buildDetailRow(
              icon: CupertinoIcons.location_solid,
              label: 'Place of Birth',
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
        Icon(icon, size: 16.sp, color: AppColors.primary),
        SizedBox(width: 10.w),
        Text(
          '$label: ',
          style: TextStyle(
            color: AppColors.textMutedDark,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
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
