import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';
import 'package:folbari/features/basket/domain/repositories/basket_repository.dart';

class GetBasketItems {
  final BasketRepository repository;

  GetBasketItems(this.repository);

  Future<List<BasketItemEntity>> call() async {
    return await repository.getBasketItems();
  }
}

class AddToBasket {
  final BasketRepository repository;

  AddToBasket(this.repository);

  Future<void> call(BasketItemEntity item) async {
    await repository.addToBasket(item);
  }
}

class RemoveFromBasket {
  final BasketRepository repository;

  RemoveFromBasket(this.repository);

  Future<void> call(String itemId) async {
    await repository.removeFromBasket(itemId);
  }
}

class UpdateBasketQuantity {
  final BasketRepository repository;

  UpdateBasketQuantity(this.repository);

  Future<void> call(String itemId, int quantity) async {
    await repository.updateQuantity(itemId, quantity);
  }
}
