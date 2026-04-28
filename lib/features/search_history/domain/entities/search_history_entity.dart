class SearchHistoryEntity {
  final String id;
  final String query;
  final DateTime createdAt;

  const SearchHistoryEntity({
    required this.id,
    required this.query,
    required this.createdAt,
  });
}
