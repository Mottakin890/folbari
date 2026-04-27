import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class ProductDetailHeader extends StatelessWidget {
  final String productImage;
  const ProductDetailHeader({super.key, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.cFFA451),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
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
                        const Icon(Icons.arrow_back_ios, size: 16, color: AppColors.c27214D),
                        Text(
                          'Go back',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.c27214D,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Hero(
              tag: productImage,
              child: Image.asset(productImage, height: 200.h, fit: BoxFit.contain),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
