import 'package:folbari/features/basket/data/models/basket_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class BasketRemoteDataSource {
  Future<List<BasketItemModel>> getBasketItems();
  Future<void> addToBasket(BasketItemModel item);
  Future<void> removeFromBasket(String itemId);
  Future<void> updateQuantity(String itemId, int quantity);
}

class BasketRemoteDataSourceImpl implements BasketRemoteDataSource {
  final SupabaseClient supabaseClient;

  BasketRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<BasketItemModel>> getBasketItems() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        logger.w('Fetching basket items: No user logged in');
        return [];
      }

      logger.i('Fetching basket items for user: $userId');
      final response = await supabaseClient
          .from('basket_items')
          .select()
          .eq('user_id', userId);
      
      final items = (response as List).map((e) => BasketItemModel.fromJson(e)).toList();
      
      return items;
    } catch (e) {
      logger.e('Error fetching basket items', error: e);
      rethrow;
    }
  }

  @override
  Future<void> addToBasket(BasketItemModel item) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        logger.w('Adding to basket: No user logged in');
        return;
      }

      logger.i('Adding item to basket: ${item.productName}');
      await supabaseClient.from('basket_items').upsert({
        ...item.toJson(),
        'user_id': userId,
      });
    } catch (e) {
      logger.e('Error adding to basket', error: e);
      rethrow;
    }
  }

  @override
  Future<void> removeFromBasket(String itemId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Removing item from basket: $itemId');
      await supabaseClient
          .from('basket_items')
          .delete()
          .eq('id', itemId)
          .eq('user_id', userId);
    } catch (e) {
      logger.e('Error removing from basket', error: e);
      rethrow;
    }
  }

  @override
  Future<void> updateQuantity(String itemId, int quantity) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Updating quantity for item $itemId to $quantity');
      await supabaseClient
          .from('basket_items')
          .update({'quantity': quantity})
          .eq('id', itemId)
          .eq('user_id', userId);
    } catch (e) {
      logger.e('Error updating quantity', error: e);
      rethrow;
    }
  }
}
