import 'package:folbari/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.userId,
    required super.message,
    required super.isFromUser,
    required super.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      message: json['message'] as String,
      isFromUser: json['is_from_user'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'message': message,
      'is_from_user': isFromUser,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
