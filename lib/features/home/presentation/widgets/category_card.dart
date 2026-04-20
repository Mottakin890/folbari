import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/core/theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final ProductEntity product;
  final Color backgroundColor;
  final VoidCallback onAddTap;
  final VoidCallback onFavoriteTap;

  const CategoryCard({super.key, 
    required this.product,
    required this.backgroundColor,
    required this.onAddTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacing.vertical(10),
              Image.asset(product.image, height: 64.h, fit: BoxFit.contain),
              Spacing.vertical(8),
              Text(
                product.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c27214D,
                  fontFamily: 'Brandon Grotesque',
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₦ ${product.price}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.cFFA451,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                  GestureDetector(
                    onTap: onAddTap,
                    child: Container(
                      padding: REdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.cFFFAEB,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.cFFA451,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColors.cFFA451,
                size: 18.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
