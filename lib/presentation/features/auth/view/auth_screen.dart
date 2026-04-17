import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:folbari/core/dimentions/spacings.dart';
import 'package:folbari/presentation/core/resources/app_assets.dart';
import 'package:folbari/presentation/core/theme/app_colors.dart';
import 'package:folbari/presentation/features/auth/widgets/o_auth_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
          ),
          SliverToBoxAdapter(
            child: RPadding(
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing.vertical(30),
                  Row(
                    children: [
                      Text(
                        'Join in',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.c27214D,
                          fontFamily: 'Brandon Grotesque',
                        ),
                      ),

                      Spacing.horizontal(8),
                      Text.rich(
                        TextSpan(
                          text: 'Fol',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Calinastiya',
                            color: AppColors.cC9D52B,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: ' Bari',
                              style: TextStyle(color: AppColors.cFFA451),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Text(
                    "Let's find some freshness, starting from today..",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                  Spacing.vertical(30),
                  OAuthButton(
                    onTap: () {},
                    buttonText: 'with Facebook',
                    buttonColor: AppColors.cFFA451,
                  ),
                  Spacing.vertical(8),
                  OAuthButton(
                    onTap: () {},
                    buttonText: 'with Google',
                    buttonColor: AppColors.cC9D52B,
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
