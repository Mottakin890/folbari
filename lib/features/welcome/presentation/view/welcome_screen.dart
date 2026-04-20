import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/resources/app_assets.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.cFFA451,
            expandedHeight: 469.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacing.vertical(80),
                    Image.asset(
                      AppAssets.foods,
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
          ),
          SliverToBoxAdapter(
            child: RPadding(
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing.vertical(50),
                  Text(
                    'Get The Freshest Fruit Salad Combo',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.c27214D,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                  Spacing.vertical(8),
                  Text(
                    'We deliver the best and freshest fruit salad in town. Order for a combo today!!!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.c5D577E,
                      fontFamily: 'Brandon Grotesque',
                      height: 1.5,
                    ),
                  ),
                  Spacing.vertical(50),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go(AppPages.auth);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cFFA451,
                        foregroundColor: AppColors.cFFFFFF,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Let’s Continue',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Brandon Grotesque',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
