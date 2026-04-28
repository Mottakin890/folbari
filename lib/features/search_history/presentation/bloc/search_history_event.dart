abstract class SearchHistoryEvent {}

class LoadSearchHistory extends SearchHistoryEvent {}

class AddSearchQuery extends SearchHistoryEvent {
  final String query;
  AddSearchQuery({required this.query});
}

class DeleteSearchQuery extends SearchHistoryEvent {
  final String id;
  DeleteSearchQuery({required this.id});
}

class ClearSearchHistoryEvent extends SearchHistoryEvent {}
