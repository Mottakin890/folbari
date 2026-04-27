import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_event.dart';
import 'package:folbari/features/auth/presentation/widgets/o_auth_button.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: AppColors.cFFFFFF,
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign In Required',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacing.vertical(16),
            Text(
              'Please sign in to add items to your basket and save your experience.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.c86869E),
            ),
            Spacing.vertical(24),
            OAuthButton(
              onTap: () {
                context.read<AuthBloc>().add(GoogleSignInRequested());
                Navigator.pop(context);
              },
              buttonText: 'with Google',
              buttonColor: AppColors.cFFA451,
            ),
            Spacing.vertical(12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.c86869E,
                  fontFamily: 'Brandon Grotesque',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAuthDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AuthDialog(),
  );
}
