import 'package:folbari/features/chat/data/models/chat_message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatMessageModel>> getChatMessages({String? userId});
  Future<void> sendMessage(String message, {String? userId, bool isFromUser = true});
  Stream<List<ChatMessageModel>> getChatStream({String? userId});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SupabaseClient supabaseClient;

  ChatRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<ChatMessageModel>> getChatMessages({String? userId}) async {
    try {
      final targetUserId = userId ?? supabaseClient.auth.currentUser?.id;
      if (targetUserId == null) return [];

      logger.i('Fetching chat messages for user: $targetUserId');
      final response = await supabaseClient
          .from('chat_messages')
          .select()
          .eq('user_id', targetUserId)
          .order('created_at', ascending: true);

      return (response as List)
          .map((data) => ChatMessageModel.fromJson(data))
          .toList();
    } catch (e) {
      logger.e('Error fetching chat messages', error: e);
      return [];
    }
  }

  @override
  Future<void> sendMessage(String message, {String? userId, bool isFromUser = true}) async {
    try {
      final targetUserId = userId ?? supabaseClient.auth.currentUser?.id;
      if (targetUserId == null) return;

      logger.i('Sending chat message for user: $targetUserId');
      await supabaseClient.from('chat_messages').insert({
        'user_id': targetUserId,
        'message': message,
        'is_from_user': isFromUser,
      });
    } catch (e) {
      logger.e('Error sending chat message', error: e);
      rethrow;
    }
  }

  @override
  Stream<List<ChatMessageModel>> getChatStream({String? userId}) {
    final targetUserId = userId ?? supabaseClient.auth.currentUser?.id;
    if (targetUserId == null) return Stream.value([]);

    return supabaseClient
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .eq('user_id', targetUserId)
        .order('created_at', ascending: true)
        .map((data) => data.map((json) => ChatMessageModel.fromJson(json)).toList());
  }
}
