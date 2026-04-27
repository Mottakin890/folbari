import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();
}

class ToggleFavorite extends ProductEvent {
  final String productId;
  const ToggleFavorite(this.productId);

  @override
  List<Object?> get props => [productId];
}
