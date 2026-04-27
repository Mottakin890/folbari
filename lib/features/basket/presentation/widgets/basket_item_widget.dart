import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';

class BasketItemWidget extends StatelessWidget {
  final BasketItemEntity item;
  const BasketItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: REdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cFFFAEB,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(
            item.productImage,
            width: 50.w,
            height: 50.h,
            fit: BoxFit.contain,
          ),
        ),
        Spacing.horizontal(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName,
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                '${item.quantity} packs',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.c27214D),
              ),
            ],
          ),
        ),
        Text(
          '৳ ${item.productPrice}',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
