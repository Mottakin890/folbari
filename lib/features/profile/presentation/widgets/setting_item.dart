import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cFFA451.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppColors.cFFA451, size: 20.sp),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.c27214D,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.c86869E),
            ),
          Spacing.horizontal(8),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.c86869E),
        ],
      ),
    );
  }
}
