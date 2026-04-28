import 'package:folbari/features/favorites/data/models/favorite_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite(String productId);
  Future<void> removeFavorite(String productId);
  Future<bool> isFavorite(String productId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final SupabaseClient supabaseClient;

  FavoriteRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return [];

      logger.i('Fetching favorites for user: $userId');
      final response = await supabaseClient
          .from('favorites')
          .select()
          .eq('user_id', userId);

      final favorites = (response as List)
          .map((data) => FavoriteModel.fromJson(data))
          .toList();

      logger.d('Fetched ${favorites.length} favorites');
      return favorites;
    } catch (e) {
      logger.e('Error fetching favorites', error: e);
      return [];
    }
  }

  @override
  Future<void> addFavorite(String productId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Adding product $productId to favorites');
      await supabaseClient.from('favorites').insert({
        'user_id': userId,
        'product_id': productId,
      });
    } catch (e) {
      logger.e('Error adding favorite', error: e);
    }
  }

  @override
  Future<void> removeFavorite(String productId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Removing product $productId from favorites');
      await supabaseClient
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      logger.e('Error removing favorite', error: e);
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return false;

      final response = await supabaseClient
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('product_id', productId);

      return (response as List).isNotEmpty;
    } catch (e) {
      logger.e('Error checking favorite status', error: e);
      return false;
    }
  }
}
