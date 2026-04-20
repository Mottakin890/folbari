import 'package:equatable/equatable.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> recommendedProducts;
  final List<ProductEntity> categoryProducts;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.recommendedProducts = const [],
    this.categoryProducts = const [],
    this.errorMessage,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? recommendedProducts,
    List<ProductEntity>? categoryProducts,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      categoryProducts: categoryProducts ?? this.categoryProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, recommendedProducts, categoryProducts, errorMessage];
}
