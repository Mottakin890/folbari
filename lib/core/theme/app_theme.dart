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
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.cFFA451,
        primary: AppColors.cFFA451,
        secondary: AppColors.c27214D,
        surface: AppColors.cFFFFFF,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.c27214D, size: 24.sp),
        titleTextStyle: AppTextStyles.h3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cFFA451,
          foregroundColor: AppColors.cFFFFFF,
          textStyle: AppTextStyles.button,
          padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
          elevation: 0,
          shadowColor: AppColors.cFFA451.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith<double>((states) {
            if (states.contains(WidgetState.pressed)) return 0;
            return 8;
          }),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.cFFA451.withValues(alpha: 0.3), width: 1),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cFFFFFF,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
