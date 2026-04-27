import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/resources/app_assets.dart';
import 'package:folbari/core/theme/app_colors.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.cFFA451,
      expandedHeight: 469.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacing.vertical(80),
              Image.asset(
                AppAssets.fruits,
                fit: BoxFit.contain,
                width: 301.w,
                height: 260.h,
              ),
              Spacing.vertical(4),
              SvgPicture.asset(AppAssets.shadow, fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}
