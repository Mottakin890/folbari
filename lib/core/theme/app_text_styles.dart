import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String brandonGrotesque = 'Brandon Grotesque';
  static const String calinastiya = 'Calinastiya';

  static TextStyle get h1 => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.c27214D,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get h2 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.c27214D,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get h3 => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.c27214D,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get bodyLarge => TextStyle(
        fontSize: 18.sp,
        color: AppColors.c27214D,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 16.sp,
        color: AppColors.c27214D,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 14.sp,
        color: AppColors.c070648,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get hint => TextStyle(
        fontSize: 16.sp,
        color: AppColors.c86869E,
        fontFamily: brandonGrotesque,
      );

  static TextStyle get button => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.cFFFFFF,
        fontFamily: brandonGrotesque,
      );
}
