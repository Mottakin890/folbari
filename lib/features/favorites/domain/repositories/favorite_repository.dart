import 'package:folbari/features/favorites/data/models/favorite_model.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite(String productId);
  Future<void> removeFavorite(String productId);
  Future<bool> isFavorite(String productId);
}
