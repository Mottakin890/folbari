import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';
import 'package:folbari/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:folbari/features/auth/presentation/widgets/auth_content_section.dart';
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
      child: const Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: CustomScrollView(
          slivers: <Widget>[
            AuthAppBar(),
            AuthContentSection(),
          ],
        ),
      ),
    );
  }
}
