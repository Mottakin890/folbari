import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_event.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cFFFFFF,
      width: 0.75.sw,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Premium Header
          _DrawerHeader(),
          
          Expanded(
            child: ListView(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Account Settings',
                  onTap: () => context.push(AppPages.settings),
                ),
                _DrawerItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Help Center',
                  onTap: () => context.push(AppPages.chat),
                ),
                _DrawerItem(
                  icon: Icons.history_rounded,
                  title: 'My Orders',
                  onTap: () => context.push(AppPages.orderHistory),
                ),
                _DrawerItem(
                  icon: Icons.favorite_border_rounded,
                  title: 'Favorites',
                  onTap: () => context.push(AppPages.favorites),
                ),
                _DrawerItem(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery Addresses',
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          // Logout Section
          Padding(
            padding: REdgeInsets.all(24),
            child: InkWell(
              onTap: () => context.read<AuthBloc>().add(const SignOutRequested()),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: REdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded, color: Colors.red),
                    Spacing.horizontal(16),
                    Text(
                      'Log Out',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
      decoration: const BoxDecoration(
        color: AppColors.cFFA451,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state.user;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: REdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.cFFFFFF,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundColor: AppColors.cF3F4F9,
                  backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
                  child: user?.avatarUrl == null
                      ? Icon(Icons.person, color: AppColors.cFFA451, size: 35.sp)
                      : null,
                ),
              ),
              Spacing.vertical(16),
              Text(
                'Hello,',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.cFFFFFF.withValues(alpha: 0.8),
                ),
              ),
              Text(
                user?.name ?? 'User',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.cFFFFFF,
                  fontSize: 22.sp,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        leading: Container(
          padding: REdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cF3F4F9,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColors.cFFA451, size: 20.sp),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.c27214D,
          ),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: AppColors.c86869E, size: 20.sp),
      ),
    );
  }
}
