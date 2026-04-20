import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/resources/app_assets.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_event.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';
import 'package:folbari/features/auth/presentation/widgets/o_auth_button.dart';
import 'package:folbari/core/utils/toast_util.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(AppPages.home);
        } else if (state.status == AuthStatus.error) {
          ToastUtil.showError(state.errorMessage ?? 'Authentication Error');
        }
      },
      child: Scaffold(
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
                    BlocSelector<AuthBloc, AuthState, AuthStatus>(
                      selector: (state) => state.status,
                      builder: (context, status) {
                        return OAuthButton(
                          onTap: status == AuthStatus.loading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                        GoogleSignInRequested(),
                                      );
                                },
                          buttonText: status == AuthStatus.loading
                              ? 'Loading...'
                              : 'with Google',
                          buttonColor: AppColors.cFFA451,
                        );
                      },
                    ),
                    Spacing.vertical(9),
                    Center(
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: 'Brandon Grotesque',
                        ),
                      ),
                    ),
                    Spacing.vertical(9),
                    BlocSelector<AuthBloc, AuthState, AuthStatus>(
                      selector: (state) => state.status,
                      builder: (context, status) {
                        return OAuthButton(
                          onTap: status == AuthStatus.loading
                              ? null
                              : () {
                                  context.go(AppPages.home);
                                },
                          buttonText: status == AuthStatus.loading
                              ? 'Loading...'
                              : 'visit our platform',
                          buttonColor: AppColors.cC9D52B,
                        );
                      },
                    ),
                    Spacing.vertical(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
