import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_event.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:go_router/go_router.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: REdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.cFFFFFF,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              size: 24.sp,
              color: AppColors.c070648,
            ),
          ),
        ),
        Spacing.vertical(16),
        Container(
          padding: REdgeInsets.only(
            left: 24,
            right: 24,
            top: 40,
            bottom: MediaQuery.of(context).viewInsets.bottom + 40,
          ),
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery address',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c27214D,
                  fontFamily: 'Brandon Grotesque',
                ),
              ),
              Spacing.vertical(16),
              BlocSelector<CheckoutBloc, CheckoutState, String>(
                selector: (state) => state.address,
                builder: (context, address) {
                  return TextField(
                    onChanged: (value) =>
                        context.read<CheckoutBloc>().add(UpdateAddress(value)),
                    decoration: InputDecoration(
                      hintText: '10th avenue, Lekki, Lagos State',
                      hintStyle: TextStyle(
                        color: AppColors.c86869E.withValues(alpha: 0.5),
                        fontSize: 16.sp,
                        fontFamily: 'Brandon Grotesque',
                      ),
                      filled: true,
                      fillColor: AppColors.cF3F4F9,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: REdgeInsets.all(20),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.c27214D,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  );
                },
              ),
              Spacing.vertical(24),
              Text(
                'Number we can call',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c27214D,
                  fontFamily: 'Brandon Grotesque',
                ),
              ),
              Spacing.vertical(16),
              BlocSelector<CheckoutBloc, CheckoutState, String>(
                selector: (state) => state.phoneNumber,
                builder: (context, phoneNumber) {
                  return TextField(
                    onChanged: (value) =>
                        context.read<CheckoutBloc>().add(UpdatePhoneNumber(value)),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '09090605708',
                      hintStyle: TextStyle(
                        color: AppColors.c86869E.withValues(alpha: 0.5),
                        fontSize: 16.sp,
                        fontFamily: 'Brandon Grotesque',
                      ),
                      filled: true,
                      fillColor: AppColors.cF3F4F9,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: REdgeInsets.all(20),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.c27214D,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  );
                },
              ),
              Spacing.vertical(40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<CheckoutBloc>().add(SubmitCheckout('delivery'));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: REdgeInsets.symmetric(vertical: 24),
                        side: const BorderSide(color: AppColors.cFFA451),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Pay on delivery',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.cFFA451,
                          fontFamily: 'Brandon Grotesque',
                        ),
                      ),
                    ),
                  ),
                  Spacing.horizontal(16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<CheckoutBloc>().add(SubmitCheckout('card'));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: REdgeInsets.symmetric(vertical: 24),
                        side: const BorderSide(color: AppColors.cFFA451),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Pay with card',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.cFFA451,
                          fontFamily: 'Brandon Grotesque',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
