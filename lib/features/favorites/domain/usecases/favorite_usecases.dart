import 'package:folbari/features/favorites/data/models/favorite_model.dart';
import 'package:folbari/features/favorites/domain/repositories/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase({required this.repository});

  Future<List<FavoriteModel>> call() async {
    return await repository.getFavorites();
  }
}

class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase({required this.repository});

  Future<void> call(String productId) async {
    return await repository.addFavorite(productId);
  }
}

class RemoveFavoriteUseCase {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  Future<void> call(String productId) async {
    return await repository.removeFavorite(productId);
  }
}

class CheckIsFavoriteUseCase {
  final FavoriteRepository repository;

  CheckIsFavoriteUseCase({required this.repository});

  Future<bool> call(String productId) async {
    return await repository.isFavorite(productId);
  }
}
