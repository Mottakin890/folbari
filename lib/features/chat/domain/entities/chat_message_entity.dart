import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String id;
  final String userId;
  final String message;
  final bool isFromUser;
  final DateTime createdAt;

  const ChatMessageEntity({
    required this.id,
    required this.userId,
    required this.message,
    required this.isFromUser,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, message, isFromUser, createdAt];
}
