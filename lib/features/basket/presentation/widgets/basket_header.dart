import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class BasketHeader extends StatelessWidget {
  const BasketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.cFFA451),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 24,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: AppColors.c27214D,
                      ),
                      Text(
                        'Go back',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'My Basket',
              style: AppTextStyles.h2.copyWith(color: AppColors.cFFFFFF),
            ),
          ],
        ),
      ),
    );
  }
}
