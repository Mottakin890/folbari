import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/presentation/core/theme/app_colors.dart';

class OAuthButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? buttonColor;
  final String buttonText;

  const OAuthButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Brandon Grotesque',
              color: AppColors.cFFFFFF,
            ),
          ),
        ),
      ),
    );
  }
}
