import 'package:folbari/features/search_history/domain/entities/search_history_entity.dart';

class SearchHistoryModel extends SearchHistoryEntity {
  const SearchHistoryModel({
    required super.id,
    required super.query,
    required super.createdAt,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json['id'] as String,
      query: json['query'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'query': query,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
