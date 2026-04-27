import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success Icon
              Container(
                width: 164.w,
                height: 164.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0FFE5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CD964),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 60.sp),
                  ),
                ),
              ),
              Spacing.vertical(56),
              // Congratulations Text
              Text(
                'Congratulations!!!',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.c27214D,
                  fontSize: 32.sp,
                ),
              ),
              Spacing.vertical(16),
              // Subtitle Text
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Your order have been taken and is being attended to',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.c27214D,
                    height: 1.5,
                  ),
                ),
              ),
              const Spacer(),
              // Track Order Button
              SizedBox(
                width: 146.w,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(AppPages.orderHistory);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: REdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.cFFA451,
                  ),
                  child: Text('Track order', style: AppTextStyles.button),
                ),
              ),
              Spacing.vertical(24),
              // Continue Shopping Button
              SizedBox(
                width: 220.w,
                child: OutlinedButton(
                  onPressed: () {
                    context.go(AppPages.home);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: REdgeInsets.symmetric(vertical: 20),
                    side: const BorderSide(color: AppColors.cFFA451),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Continue shopping',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.cFFA451,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Spacing.vertical(40),
            ],
          ),
        ),
      ),
    );
  }
}
