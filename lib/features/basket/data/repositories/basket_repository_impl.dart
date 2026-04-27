import 'package:folbari/features/basket/data/datasources/basket_remote_data_source.dart';
import 'package:folbari/features/basket/data/models/basket_item_model.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';
import 'package:folbari/features/basket/domain/repositories/basket_repository.dart';

class BasketRepositoryImpl implements BasketRepository {
  final BasketRemoteDataSource remoteDataSource;

  BasketRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BasketItemEntity>> getBasketItems() async {
    return await remoteDataSource.getBasketItems();
  }

  @override
  Future<void> addToBasket(BasketItemEntity item) async {
    await remoteDataSource.addToBasket(BasketItemModel.fromEntity(item));
  }

  @override
  Future<void> removeFromBasket(String itemId) async {
    await remoteDataSource.removeFromBasket(itemId);
  }

  @override
  Future<void> updateQuantity(String itemId, int quantity) async {
    await remoteDataSource.updateQuantity(itemId, quantity);
  }
}
