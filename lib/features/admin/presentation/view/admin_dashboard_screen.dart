import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_event.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_state.dart';
import 'package:folbari/features/admin/presentation/view/user_manager_screen.dart';
import 'package:folbari/features/admin/presentation/view/product_manager_screen.dart';
import 'package:folbari/features/admin/presentation/view/admin_chat_list_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(LoadAdminDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: AppBar(
        title: Text('Admin Control', style: AppTextStyles.h2.copyWith(color: Colors.white)),
        backgroundColor: AppColors.cFFA451,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<AdminBloc>().add(LoadAdminDashboard()),
          ),
        ],
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state.status == AdminStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.cFFA451));
          }
          if (state.status == AdminStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.red, size: 64),
                  Spacing.vertical(16),
                  Text('Error: ${state.error}', style: AppTextStyles.bodyMedium),
                  Spacing.vertical(16),
                  ElevatedButton(
                    onPressed: () => context.read<AdminBloc>().add(LoadAdminDashboard()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final analytics = state.analytics;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: REdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader('Performance Overview'),
                Spacing.vertical(16),
                _buildRevenueChart(analytics['total_revenue'] ?? 0),
                Spacing.vertical(24),
                _buildHeader('Key Statistics'),
                Spacing.vertical(16),
                _buildStatsGrid(analytics),
                Spacing.vertical(32),
                _buildHeader('Quick Management'),
                Spacing.vertical(16),
                _buildActionTile(
                  context,
                  'User Base',
                  'Manage accounts and permissions',
                  Icons.group_outlined,
                  const Color(0xFF6366F1),
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserManagerScreen())),
                ),
                _buildActionTile(
                  context,
                  'Product Catalog',
                  'Inventory and pricing control',
                  Icons.inventory_2_outlined,
                  const Color(0xFF10B981),
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductManagerScreen())),
                ),
                _buildActionTile(
                  context,
                  'Help Center',
                  'Customer support interactions',
                  Icons.support_agent_rounded,
                  const Color(0xFFF59E0B),
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminChatListScreen())),
                ),
                Spacing.vertical(40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> analytics) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Users',
                    analytics['total_users']?.toString() ?? '0',
                    Icons.people_alt_rounded,
                    const Color(0xFF3B82F6),
                  ),
                ),
                Spacing.horizontal(16),
                Expanded(
                  child: _buildStatCard(
                    'Orders',
                    analytics['total_orders']?.toString() ?? '0',
                    Icons.shopping_cart_rounded,
                    const Color(0xFFEC4899),
                  ),
                ),
              ],
            ),
            Spacing.vertical(16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Products',
                    analytics['total_products']?.toString() ?? '0',
                    Icons.grid_view_rounded,
                    const Color(0xFF8B5CF6),
                  ),
                ),
                Spacing.horizontal(16),
                Expanded(
                  child: _buildStatCard(
                    'Growth',
                    '+12%', // Mock growth
                    Icons.trending_up_rounded,
                    const Color(0xFF22C55E),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          Spacing.vertical(12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: AppTextStyles.h2.copyWith(fontSize: 22.sp),
            ),
          ),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.c86869E),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart(num revenue) {
    return Container(
      height: 220.h,
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF27214D), Color(0xFF5D577E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF27214D).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Revenue',
                    style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
                  ),
                  Text(
                    '₦${revenue.toStringAsFixed(0)}',
                    style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 24.sp),
                  ),
                ],
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Last 7 Days',
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: 100.h,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 1),
                      FlSpot(2, 4),
                      FlSpot(3, 2),
                      FlSpot(4, 5),
                      FlSpot(5, 3),
                      FlSpot(6, 4),
                    ],
                    isCurved: true,
                    color: AppColors.cFFA451,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.cFFA451.withValues(alpha: 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.cF3F4F6),
        ),
        child: Row(
          children: [
            Container(
              padding: REdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            Spacing.horizontal(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.c86869E, fontSize: 12.sp)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: AppColors.c86869E, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
