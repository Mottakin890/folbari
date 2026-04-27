import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cFFFFFF,
      primaryColor: AppColors.cFFA451,
      fontFamily: AppTextStyles.brandonGrotesque,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cFFA451,
          foregroundColor: AppColors.cFFFFFF,
          textStyle: AppTextStyles.button,
          padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cF3F4F9,
        hintStyle: AppTextStyles.hint.copyWith(color: AppColors.c86869E.withValues(alpha: 0.5)),
        contentPadding: REdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
