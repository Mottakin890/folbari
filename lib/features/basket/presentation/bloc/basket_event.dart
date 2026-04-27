import 'package:equatable/equatable.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object?> get props => [];
}

class LoadBasket extends BasketEvent {
  const LoadBasket();
}

class AddItemToBasket extends BasketEvent {
  final BasketItemEntity item;
  const AddItemToBasket(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItemFromBasket extends BasketEvent {
  final String itemId;
  const RemoveItemFromBasket(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateItemQuantity extends BasketEvent {
  final String itemId;
  final int quantity;
  const UpdateItemQuantity(this.itemId, this.quantity);

  @override
  List<Object?> get props => [itemId, quantity];
}

class ClearBasket extends BasketEvent {
  const ClearBasket();
}
