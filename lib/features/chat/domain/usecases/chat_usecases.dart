import 'package:folbari/features/chat/domain/entities/chat_message_entity.dart';
import 'package:folbari/features/chat/domain/repositories/chat_repository.dart';

class GetChatMessages {
  final ChatRepository repository;

  GetChatMessages(this.repository);

  Future<List<ChatMessageEntity>> call({String? userId}) async {
    return await repository.getChatMessages(userId: userId);
  }
}

class SendChatMessage {
  final ChatRepository repository;

  SendChatMessage(this.repository);

  Future<void> call(String message, {String? userId, bool isFromUser = true}) async {
    await repository.sendMessage(message, userId: userId, isFromUser: isFromUser);
  }
}

class GetChatStream {
  final ChatRepository repository;

  GetChatStream(this.repository);

  Stream<List<ChatMessageEntity>> call({String? userId}) {
    return repository.getChatStream(userId: userId);
  }
}
