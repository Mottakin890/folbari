import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folbari/core/dimentions/spacings.dart';
import 'package:folbari/presentation/core/resources/app_assets.dart';
import 'package:folbari/presentation/core/routes/app_pages.dart';
import 'package:folbari/presentation/core/theme/app_colors.dart';
import 'package:folbari/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:folbari/presentation/features/splash/bloc/splash_state.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.loaded) {
          context.go(AppPages.welcome);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppAssets.leaf),
              SvgPicture.asset(AppAssets.top),
              Spacing.vertical(10),
              Text.rich(
                TextSpan(
                  text: 'Fol',
                  style: TextStyle(
                    fontSize: 45.sp,
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
        ),
      ),
    );
  }
}
