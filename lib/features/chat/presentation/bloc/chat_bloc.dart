import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_event.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    emit(state.copyWith(status: ChatStatus.loading));
    // Mocking initial messages
    final messages = [
      ChatMessage(
        text: 'Hello! Welcome to FolBari Support. How can we assist you today?',
        isMe: false,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
    emit(state.copyWith(status: ChatStatus.loaded, messages: messages));
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    if (event.message.trim().isEmpty) return;
    
    final newMessage = ChatMessage(
      text: event.message,
      isMe: true,
      time: DateTime.now(),
    );
    
    final updatedMessages = List<ChatMessage>.from(state.messages)..add(newMessage);
    emit(state.copyWith(messages: updatedMessages));
  }
}
