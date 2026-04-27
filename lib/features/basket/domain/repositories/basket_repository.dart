import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';

abstract class BasketRepository {
  Future<List<BasketItemEntity>> getBasketItems();
  Future<void> addToBasket(BasketItemEntity item);
  Future<void> removeFromBasket(String itemId);
  Future<void> updateQuantity(String itemId, int quantity);
}
