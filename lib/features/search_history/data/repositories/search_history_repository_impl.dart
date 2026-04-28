import 'package:folbari/features/search_history/data/datasources/search_history_remote_data_source.dart';
import 'package:folbari/features/search_history/data/models/search_history_model.dart';
import 'package:folbari/features/search_history/domain/repositories/search_history_repository.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final SearchHistoryRemoteDataSource remoteDataSource;

  SearchHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SearchHistoryModel>> getSearchHistory() {
    return remoteDataSource.getSearchHistory();
  }

  @override
  Future<void> addSearchQuery(String query) {
    return remoteDataSource.addSearchQuery(query);
  }

  @override
  Future<void> deleteSearchQuery(String id) {
    return remoteDataSource.deleteSearchQuery(id);
  }

  @override
  Future<void> clearSearchHistory() {
    return remoteDataSource.clearSearchHistory();
  }
}
