import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:folbari/core/resources/app_assets.dart';
import 'package:folbari/core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          AppAssets.leadingIcon,
          colorFilter: const ColorFilter.mode(
            AppColors.c070648,
            BlendMode.srcIn,
          ),
        ),
        Column(
          children: [
            SvgPicture.asset(AppAssets.basket),
            Text(
              'My basket',
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.c27214D,
                fontFamily: 'Brandon Grotesque',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
