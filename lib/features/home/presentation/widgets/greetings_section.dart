import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';

class GreetingsSection extends StatelessWidget {
  const GreetingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, String?>(
      selector: (state) => state.user?.name,
      builder: (context, name) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hello ${name ?? 'User'}, ',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.c5D577E,
                  fontFamily: 'Brandon Grotesque',
                ),
                children: [
                  TextSpan(
                    text: 'What fruit salad\ncombo do you want today?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.c27214D,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
