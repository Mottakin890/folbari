import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/presentation/bloc/product_bloc.dart';
import 'package:folbari/features/home/presentation/bloc/product_event.dart';
import 'package:folbari/features/home/presentation/bloc/product_state.dart';
import 'package:folbari/features/home/presentation/widgets/recommended_card.dart';

class RecommendedComboList extends StatelessWidget {
  const RecommendedComboList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, List<ProductEntity>>(
      selector: (state) => state.recommendedProducts,
      builder: (context, products) {
        if (products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          separatorBuilder: (context, index) => Spacing.horizontal(16),
          itemBuilder: (context, index) {
            final product = products[index];
            return RecommendedCard(
              product: product,
              onAddTap: () {},
              onFavoriteTap: () {
                context.read<ProductBloc>().add(ToggleFavorite(product.id));
              },
            );
          },
        );
      },
    );
  }
}
