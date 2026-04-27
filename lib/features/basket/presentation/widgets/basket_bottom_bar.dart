import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_state.dart';
import 'package:folbari/features/checkout/presentation/widgets/checkout_bottom_sheet.dart';

class BasketBottomBar extends StatelessWidget {
  const BasketBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BasketBloc, BasketState, (double, bool)>(
      selector: (state) => (state.totalPrice, state.items.isEmpty),
      builder: (context, data) {
        final (totalPrice, isEmpty) = data;
        if (isEmpty) return const SizedBox.shrink();

        return Container(
          padding: REdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.c27214D,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                  Text(
                    '৳ ${totalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.c27214D,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const CheckoutBottomSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cFFA451,
                  padding: REdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.cFFFFFF,
                    fontFamily: 'Brandon Grotesque',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
