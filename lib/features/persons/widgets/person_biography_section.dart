import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final bioText = hasBio ? widget.biography!.trim() : 'No biography available for this artist yet.';
    final isLongBio = bioText.length > 250;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isExpanded || !isLongBio
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              bioText,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: hasBio ? AppColors.textPrimaryDark : AppColors.textSecondaryDark,
                fontSize: 13.5.sp,
                height: 1.7,
                letterSpacing: 0.15,
              ),
            ),
            secondChild: Text(
              bioText,
              style: TextStyle(
                color: hasBio ? AppColors.textPrimaryDark : AppColors.textSecondaryDark,
                fontSize: 13.5.sp,
                height: 1.7,
                letterSpacing: 0.15,
              ),
            ),
          ),
          if (hasBio && isLongBio) ...[
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? 'Show Less' : 'Read Full Biography',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    _isExpanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                    size: 13.sp,
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
