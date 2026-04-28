import 'package:folbari/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatRepository {
  Future<List<ChatMessageEntity>> getChatMessages({String? userId});
  Future<void> sendMessage(String message, {String? userId, bool isFromUser = true});
  Stream<List<ChatMessageEntity>> getChatStream({String? userId});
}
