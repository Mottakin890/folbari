import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class RecommendedCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onAddTap;
  final VoidCallback onFavoriteTap;

  const RecommendedCard({
    super.key,
    required this.product,
    required this.onAddTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppPages.productDetail, extra: product),
      child: Container(
        width: 150.w,
        padding: REdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacing.vertical(10),
                Image.asset(product.image, height: 80.h, fit: BoxFit.contain),
                Spacing.vertical(12),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.c27214D,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '৳ ${product.price}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.cFFA451,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _AddIcon(onTap: onAddTap),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: _FavoriteIcon(
                isFavorite: product.isFavorite,
                onTap: onFavoriteTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddIcon extends StatelessWidget {
  final VoidCallback onTap;
  const _AddIcon({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColors.cFFFAEB,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.cFFA451,
          size: 20,
        ),
      ),
    );
  }
}

class _FavoriteIcon extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _FavoriteIcon({required this.isFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: AppColors.cFFA451,
        size: 20.r,
      ),
    );
  }
}
