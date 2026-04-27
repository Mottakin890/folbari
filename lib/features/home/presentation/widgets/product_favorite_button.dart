import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';

class ProductFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  const ProductFavoriteButton({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.cFFFAEB,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: AppColors.cFFA451,
      ),
    );
  }
}
