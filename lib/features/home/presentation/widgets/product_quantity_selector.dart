import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/home/presentation/bloc/product_detail_cubit.dart';

class ProductQuantitySelector extends StatelessWidget {
  const ProductQuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuantityButton(
          icon: Icons.remove,
          onTap: () => context.read<ProductDetailCubit>().decrement(),
        ),
        Spacing.horizontal(16),
        BlocSelector<ProductDetailCubit, int, int>(
          selector: (state) => state,
          builder: (context, quantity) {
            return Text(
              '$quantity',
              style: AppTextStyles.h3.copyWith(color: AppColors.c27214D),
            );
          },
        ),
        Spacing.horizontal(16),
        _QuantityButton(
          icon: Icons.add,
          isAdd: true,
          onTap: () => context.read<ProductDetailCubit>().increment(),
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isAdd;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isAdd ? AppColors.cFFFAEB : Colors.transparent,
          shape: BoxShape.circle,
          border: isAdd ? null : Border.all(color: AppColors.c27214D),
        ),
        child: Icon(
          icon,
          size: 24,
          color: isAdd ? AppColors.cFFA451 : AppColors.c27214D,
        ),
      ),
    );
  }
}
