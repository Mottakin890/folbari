import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/presentation/bloc/product_detail_cubit.dart';
import 'package:folbari/features/home/presentation/widgets/product_detail_bottom_bar.dart';
import 'package:folbari/features/home/presentation/widgets/product_detail_header.dart';
import 'package:folbari/features/home/presentation/widgets/product_details_content.dart';

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
            ProductDetailHeader(productImage: product.image),
            Expanded(
              child: ProductDetailsContent(product: product),
            ),
          ],
        ),
        bottomNavigationBar: ProductDetailBottomBar(product: product),
      ),
    );
  }
}
