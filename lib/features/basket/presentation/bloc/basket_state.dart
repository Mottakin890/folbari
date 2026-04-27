import 'package:equatable/equatable.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';

class BasketState extends Equatable {
  final List<BasketItemEntity> items;
  final bool isLoading;

  const BasketState({
    this.items = const [],
    this.isLoading = false,
  });

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  BasketState copyWith({
    List<BasketItemEntity>? items,
    bool? isLoading,
  }) {
    return BasketState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in items) {
      final priceStr = item.productPrice.replaceAll(',', '');
      total += double.parse(priceStr) * item.quantity;
    }
    return total;
  }

  @override
  List<Object?> get props => [items, isLoading];
}
