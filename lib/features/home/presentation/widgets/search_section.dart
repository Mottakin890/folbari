import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/resources/app_assets.dart';
import 'package:folbari/core/theme/app_colors.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56.h,
            padding: REdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.cF3F4F9,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.search),
                Spacing.horizontal(12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for fruit salad combos',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.c86869E,
                        fontFamily: 'Brandon Grotesque',
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacing.horizontal(16),
        SvgPicture.asset(
          AppAssets.filter,
          colorFilter: ColorFilter.mode(AppColors.c070648, BlendMode.srcIn),
        ),
      ],
    );
  }
}
