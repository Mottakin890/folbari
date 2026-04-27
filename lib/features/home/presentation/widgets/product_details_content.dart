import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/presentation/widgets/product_pack_details.dart';
import 'package:folbari/features/home/presentation/widgets/product_quantity_selector.dart';

class ProductDetailsContent extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: SingleChildScrollView(
        padding: REdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: AppTextStyles.h1.copyWith(color: AppColors.c27214D),
            ),
            Spacing.vertical(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ProductQuantitySelector(),
                Text(
                  '৳ ${product.price}',
                  style: AppTextStyles.h2.copyWith(color: AppColors.c27214D),
                ),
              ],
            ),
            Spacing.vertical(32),
            const Divider(color: AppColors.cF3F4F9),
            Spacing.vertical(32),
            ProductPackDetails(ingredients: product.ingredients),
            Spacing.vertical(32),
            const Divider(color: AppColors.cF3F4F9),
            Spacing.vertical(32),
            Text(
              product.description ?? '',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.c070648, height: 1.5),
            ),
            Spacing.vertical(40),
          ],
        ),
      ),
    );
  }
}
