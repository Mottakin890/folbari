import 'package:folbari/features/search_history/data/models/search_history_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class SearchHistoryRemoteDataSource {
  Future<List<SearchHistoryModel>> getSearchHistory();
  Future<void> addSearchQuery(String query);
  Future<void> deleteSearchQuery(String id);
  Future<void> clearSearchHistory();
}

class SearchHistoryRemoteDataSourceImpl
    implements SearchHistoryRemoteDataSource {
  final SupabaseClient supabaseClient;

  SearchHistoryRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<SearchHistoryModel>> getSearchHistory() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return [];

      logger.i('Fetching search history for user: $userId');
      final response = await supabaseClient
          .from('search_history')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(20);

      final history = (response as List)
          .map((data) => SearchHistoryModel.fromJson(data))
          .toList();

      logger.d('Fetched ${history.length} search history items');
      return history;
    } catch (e) {
      logger.e('Error fetching search history', error: e);
      return [];
    }
  }

  @override
  Future<void> addSearchQuery(String query) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Adding search query: $query');
      await supabaseClient.from('search_history').insert({
        'user_id': userId,
        'query': query,
      });
    } catch (e) {
      logger.e('Error adding search query', error: e);
    }
  }

  @override
  Future<void> deleteSearchQuery(String id) async {
    try {
      logger.i('Deleting search query: $id');
      await supabaseClient.from('search_history').delete().eq('id', id);
    } catch (e) {
      logger.e('Error deleting search query', error: e);
    }
  }

  @override
  Future<void> clearSearchHistory() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Clearing search history for user: $userId');
      await supabaseClient
          .from('search_history')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      logger.e('Error clearing search history', error: e);
    }
  }
}
