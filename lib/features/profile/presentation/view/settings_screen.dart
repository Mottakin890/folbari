import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/profile/presentation/widgets/setting_item.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_event.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_state.dart';
import 'package:folbari/features/admin/presentation/view/admin_dashboard_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.h3),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profile = state.profile;
          final isAdmin = profile?.isAdmin ?? false;
          
          return ListView(
            padding: REdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              _buildSection('Account Information', [
                SettingItem(
                  icon: Icons.person_outline_rounded,
                  title: 'Personal Profile',
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.location_on_outlined,
                  title: 'Shipping Addresses',
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.payment_rounded,
                  title: 'Payment Methods',
                  onTap: () {},
                ),
              ]),
              Spacing.vertical(32),
              _buildSection('Preferences', [
                SettingItem(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  trailingText: 'English',
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Theme Mode',
                  trailingText: 'Light',
                  onTap: () {},
                ),
              ]),
              Spacing.vertical(32),
              _buildSection('Support', [
                if (isAdmin)
                  SettingItem(
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'Admin Panel',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminDashboardScreen()));
                    },
                  ),
                SettingItem(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.info_outline_rounded,
                  title: 'About FolBari',
                  onTap: () {},
                ),
              ]),
              Spacing.vertical(40),
              Center(
                child: Text(
                  'App Version 1.0.0',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.c86869E),
                ),
              ),
              Spacing.vertical(20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.c86869E,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              return Column(
                children: [
                  items[index],
                  if (index != items.length - 1)
                    Padding(
                      padding: REdgeInsets.only(left: 56),
                      child: Divider(height: 1, color: AppColors.cF3F4F9),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
