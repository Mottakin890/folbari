import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        final firstName = name?.split(' ').first ?? 'User';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hello $firstName, ',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.c5D577E),
                children: [
                  TextSpan(
                    text: 'What fruit salad\ncombo do you want today?',
                    style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
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
