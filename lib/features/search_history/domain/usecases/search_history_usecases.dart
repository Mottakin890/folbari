import 'package:folbari/features/search_history/data/models/search_history_model.dart';
import 'package:folbari/features/search_history/domain/repositories/search_history_repository.dart';

class GetSearchHistoryUseCase {
  final SearchHistoryRepository repository;

  GetSearchHistoryUseCase({required this.repository});

  Future<List<SearchHistoryModel>> call() async {
    return await repository.getSearchHistory();
  }
}

class AddSearchQueryUseCase {
  final SearchHistoryRepository repository;

  AddSearchQueryUseCase({required this.repository});

  Future<void> call(String query) async {
    return await repository.addSearchQuery(query);
  }
}

class DeleteSearchQueryUseCase {
  final SearchHistoryRepository repository;

  DeleteSearchQueryUseCase({required this.repository});

  Future<void> call(String id) async {
    return await repository.deleteSearchQuery(id);
  }
}

class ClearSearchHistoryUseCase {
  final SearchHistoryRepository repository;

  ClearSearchHistoryUseCase({required this.repository});

  Future<void> call() async {
    return await repository.clearSearchHistory();
  }
}
