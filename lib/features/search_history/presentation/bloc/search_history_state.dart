enum SearchHistoryStatus { initial, loading, loaded, error }

class SearchHistoryState {
  final SearchHistoryStatus status;
  final List<dynamic> searchHistory;
  final String? errorMessage;

  const SearchHistoryState({
    this.status = SearchHistoryStatus.initial,
    this.searchHistory = const [],
    this.errorMessage,
  });

  SearchHistoryState copyWith({
    SearchHistoryStatus? status,
    List<dynamic>? searchHistory,
    String? errorMessage,
  }) {
    return SearchHistoryState(
      status: status ?? this.status,
      searchHistory: searchHistory ?? this.searchHistory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
