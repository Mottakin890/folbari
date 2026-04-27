import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/order/presentation/bloc/order_bloc.dart';
import 'package:folbari/features/order/presentation/bloc/order_state.dart';
import 'package:folbari/features/order/presentation/widgets/order_card.dart';
import 'package:folbari/features/order/presentation/widgets/order_history_shimmer.dart';
import 'package:go_router/go_router.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF3F4F9,
      appBar: AppBar(
        title: Text('Order History', style: AppTextStyles.h3),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const OrderHistoryShimmer();
          }

          if (state.isError) {
            return Center(child: Text(state.errorMessage ?? 'An error occurred'));
          }

          if (state.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 64.sp, color: AppColors.c86869E),
                  Spacing.vertical(16),
                  Text('No orders yet', style: AppTextStyles.bodyLarge),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: REdgeInsets.all(24),
            itemCount: state.orders.length,
            separatorBuilder: (context, index) => Spacing.vertical(16),
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return OrderCard(order: order);
            },
          );
        },
      ),
    );
  }
}
