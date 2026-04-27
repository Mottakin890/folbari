import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/core/utils/toast_util.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';
import 'package:folbari/features/auth/presentation/widgets/auth_dialog.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_event.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/presentation/bloc/product_detail_cubit.dart';
import 'package:folbari/features/home/presentation/widgets/product_favorite_button.dart';

class ProductDetailBottomBar extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailBottomBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
        children: [
          ProductFavoriteButton(isFavorite: product.isFavorite),
          Spacing.horizontal(24),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _handleAddToBasket(context),
              child: Text('Add to basket', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddToBasket(BuildContext context) {
    final authStatus = context.read<AuthBloc>().state.status;
    if (authStatus != AuthStatus.authenticated) {
      showAuthDialog(context);
    } else {
      final quantity = context.read<ProductDetailCubit>().state;
      final item = BasketItemEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: product.id,
        productName: product.name,
        productPrice: product.price,
        productImage: product.image,
        quantity: quantity,
      );
      context.read<BasketBloc>().add(AddItemToBasket(item));
      ToastUtil.showSuccess('${product.name} added to basket');
    }
  }
}
