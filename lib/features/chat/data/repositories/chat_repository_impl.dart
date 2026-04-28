import 'package:folbari/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:folbari/features/chat/domain/entities/chat_message_entity.dart';
import 'package:folbari/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ChatMessageEntity>> getChatMessages({String? userId}) async {
    return await remoteDataSource.getChatMessages(userId: userId);
  }

  @override
  Future<void> sendMessage(String message, {String? userId, bool isFromUser = true}) async {
    await remoteDataSource.sendMessage(message, userId: userId, isFromUser: isFromUser);
  }

  @override
  Stream<List<ChatMessageEntity>> getChatStream({String? userId}) {
    return remoteDataSource.getChatStream(userId: userId);
  }
}
