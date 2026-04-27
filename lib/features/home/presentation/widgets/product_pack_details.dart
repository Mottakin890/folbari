import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';

class ProductPackDetails extends StatelessWidget {
  final String? ingredients;
  const ProductPackDetails({super.key, this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'One Pack Contains:',
          style: AppTextStyles.h3.copyWith(color: AppColors.c27214D),
        ),
        Container(
          margin: REdgeInsets.only(top: 8, bottom: 16),
          height: 2.h,
          width: 150.w,
          color: AppColors.cFFA451,
        ),
        Text(
          ingredients ?? 'N/A',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.c27214D,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
