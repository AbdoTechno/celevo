import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonBiographySection extends StatefulWidget {
  final String? biography;

  const PersonBiographySection({
    super.key,
    required this.biography,
  });

  @override
  State<PersonBiographySection> createState() => _PersonBiographySectionState();
}

class _PersonBiographySectionState extends State<PersonBiographySection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasBio = widget.biography != null && widget.biography!.trim().isNotEmpty;
    final bioText = hasBio ? widget.biography!.trim() : 'No biography available for this person yet.';
    final isLongBio = bioText.length > 280;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bioText,
            maxLines: _isExpanded ? null : (isLongBio ? 5 : null),
            overflow: _isExpanded ? TextOverflow.visible : (isLongBio ? TextOverflow.ellipsis : TextOverflow.visible),
            style: TextStyle(
              color: hasBio ? AppColors.textPrimaryDark : AppColors.textSecondaryDark,
              fontSize: 13.5.sp,
              height: 1.65,
            ),
          ),
          if (hasBio && isLongBio) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? 'Read Less' : 'Read More',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    _isExpanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                    size: 14.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
