import 'package:folbari/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:folbari/features/favorites/data/models/favorite_model.dart';
import 'package:folbari/features/favorites/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<FavoriteModel>> getFavorites() {
    return remoteDataSource.getFavorites();
  }

  @override
  Future<void> addFavorite(String productId) {
    return remoteDataSource.addFavorite(productId);
  }

  @override
  Future<void> removeFavorite(String productId) {
    return remoteDataSource.removeFavorite(productId);
  }

  @override
  Future<bool> isFavorite(String productId) {
    return remoteDataSource.isFavorite(productId);
  }
}
