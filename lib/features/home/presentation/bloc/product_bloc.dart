import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/domain/usecases/get_category_products.dart';
import 'package:folbari/features/home/domain/usecases/get_recommended_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetRecommendedProducts getRecommendedProducts;
  final GetCategoryProducts getCategoryProducts;

  ProductBloc({
    required this.getRecommendedProducts,
    required this.getCategoryProducts,
  }) : super(const ProductState()) {
    on<LoadProducts>(_onLoadProducts);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    
    try {
      final recommended = await getRecommendedProducts();
      final category = await getCategoryProducts();

      emit(state.copyWith(
        status: ProductStatus.loaded,
        recommendedProducts: recommended,
        categoryProducts: category,
      ));
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.error));
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<ProductState> emit) {
    final updatedRecommended = state.recommendedProducts.map((product) {
      if (product.id == event.productId) {
        return ProductEntity(
          id: product.id,
          name: product.name,
          price: product.price,
          image: product.image,
          isFavorite: !product.isFavorite,
        );
      }
      return product;
    }).toList();

    final updatedCategory = state.categoryProducts.map((product) {
      if (product.id == event.productId) {
        return ProductEntity(
          id: product.id,
          name: product.name,
          price: product.price,
          image: product.image,
          isFavorite: !product.isFavorite,
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(
      recommendedProducts: updatedRecommended,
      categoryProducts: updatedCategory,
    ));
  }
}
