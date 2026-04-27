import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/home/presentation/bloc/product_bloc.dart';
import 'package:folbari/features/home/presentation/bloc/product_state.dart';
import 'package:folbari/features/home/presentation/widgets/recommended_card.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: AppBar(
        title: Text('My Favorites', style: AppTextStyles.h3),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final favorites = state.recommendedProducts.where((p) => p.isFavorite).toList();

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: REdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.cFFA451.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite_rounded, size: 64.sp, color: AppColors.cFFA451.withValues(alpha: 0.2)),
                  ),
                  Spacing.vertical(24),
                  Text(
                    'No favorites yet',
                    style: AppTextStyles.h3.copyWith(color: AppColors.c27214D),
                  ),
                  Spacing.vertical(8),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Your liked fruit salads will appear here for quick access.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.c86869E),
                    ),
                  ),
                  Spacing.vertical(32),
                  ElevatedButton(
                    onPressed: () => context.go('/home'),
                    style: ElevatedButton.styleFrom(
                      padding: REdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Explore Fruits'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: REdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 0.72,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return RecommendedCard(
                product: product,
                onAddTap: () {},
                onFavoriteTap: () {
                  // This is handled inside the card via Bloc
                },
              );
            },
          );
        },
      ),
    );
  }
}
