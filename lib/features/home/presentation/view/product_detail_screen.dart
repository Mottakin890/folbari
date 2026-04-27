import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';
import 'package:folbari/features/auth/presentation/widgets/auth_dialog.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_event.dart';
import 'package:folbari/core/utils/toast_util.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/presentation/bloc/product_detail_cubit.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailCubit(),
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: Column(
          children: [
            _ProductHeader(productImage: product.image),
            Expanded(
              child: _ProductDetailsContent(product: product),
            ),
          ],
        ),
        bottomNavigationBar: _ProductBottomBar(product: product),
      ),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  final String productImage;
  const _ProductHeader({required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.cFFA451),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios, size: 16, color: AppColors.c27214D),
                        Text(
                          'Go back',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.c27214D,
                            fontFamily: 'Brandon Grotesque',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Image.asset(productImage, height: 200.h, fit: BoxFit.contain),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailsContent extends StatelessWidget {
  final ProductEntity product;

  const _ProductDetailsContent({required this.product});

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
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.c27214D,
                fontFamily: 'Brandon Grotesque',
              ),
            ),
            Spacing.vertical(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _QuantitySelector(),
                Text(
                  '৳ ${product.price}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.c27214D,
                    fontFamily: 'Brandon Grotesque',
                  ),
                ),
              ],
            ),
            Spacing.vertical(32),
            const Divider(color: AppColors.cF3F4F9),
            Spacing.vertical(32),
            _PackDetails(ingredients: product.ingredients),
            Spacing.vertical(32),
            const Divider(color: AppColors.cF3F4F9),
            Spacing.vertical(32),
            Text(
              product.description ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.c070648,
                fontFamily: 'Brandon Grotesque',
              ),
            ),
            Spacing.vertical(40),
          ],
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector();

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
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.c27214D,
                fontFamily: 'Brandon Grotesque',
              ),
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

class _PackDetails extends StatelessWidget {
  final String? ingredients;
  const _PackDetails({this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'One Pack Contains:',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.c27214D,
            fontFamily: 'Brandon Grotesque',
          ),
        ),
        Container(
          margin: REdgeInsets.only(top: 4, bottom: 16),
          height: 2.h,
          width: 150.w,
          color: AppColors.cFFA451,
        ),
        Text(
          ingredients ?? 'N/A',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.c27214D,
            fontFamily: 'Brandon Grotesque',
          ),
        ),
      ],
    );
  }
}

class _ProductBottomBar extends StatelessWidget {
  final ProductEntity product;

  const _ProductBottomBar({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: AppColors.cFFFFFF,
      child: Row(
        children: [
          _FavoriteButton(isFavorite: product.isFavorite),
          Spacing.horizontal(24),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _handleAddToBasket(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cFFA451,
                padding: REdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Add to basket',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.cFFFFFF,
                  fontFamily: 'Brandon Grotesque',
                ),
              ),
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

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  const _FavoriteButton({required this.isFavorite});

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
