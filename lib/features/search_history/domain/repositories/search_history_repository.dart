import 'package:folbari/features/search_history/data/models/search_history_model.dart';

abstract class SearchHistoryRepository {
  Future<List<SearchHistoryModel>> getSearchHistory();
  Future<void> addSearchQuery(String query);
  Future<void> deleteSearchQuery(String id);
  Future<void> clearSearchHistory();
}
