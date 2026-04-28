import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/chat/domain/usecases/chat_usecases.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_event.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_state.dart';
import 'dart:async';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatMessages getChatMessages;
  final SendChatMessage sendChatMessage;
  final GetChatStream getChatStream;
  StreamSubscription? _chatSubscription;

  ChatBloc({
    required this.getChatMessages,
    required this.sendChatMessage,
    required this.getChatStream,
  }) : super(const ChatState()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<UpdateMessages>(_onUpdateMessages);
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading, isAdmin: event.targetUserId != null));
    try {
      final entities = await getChatMessages(userId: event.targetUserId);
      final messages = entities.map((e) => ChatMessage(
        text: e.message,
        isMe: state.isAdmin ? !e.isFromUser : e.isFromUser,
        time: e.createdAt,
      )).toList();
      
      emit(state.copyWith(status: ChatStatus.loaded, messages: messages));
      
      // Start real-time subscription
      await _chatSubscription?.cancel();
      _chatSubscription = getChatStream(userId: event.targetUserId).listen((entities) {
        add(UpdateMessages(entities));
      });
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, error: e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    if (event.message.trim().isEmpty) return;
    
    try {
      await sendChatMessage(
        event.message, 
        userId: event.targetUserId, 
        isFromUser: !event.isAdmin,
      );
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, error: e.toString()));
    }
  }

  void _onUpdateMessages(UpdateMessages event, Emitter<ChatState> emit) {
    final messages = event.entities.map((e) => ChatMessage(
      text: e.message,
      isMe: state.isAdmin ? !e.isFromUser : e.isFromUser,
      time: e.createdAt,
    )).toList();
    emit(state.copyWith(status: ChatStatus.loaded, messages: messages));
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
