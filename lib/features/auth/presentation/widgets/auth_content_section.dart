import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_event.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';
import 'package:folbari/features/auth/presentation/widgets/o_auth_button.dart';
import 'package:go_router/go_router.dart';

class AuthContentSection extends StatelessWidget {
  const AuthContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}
