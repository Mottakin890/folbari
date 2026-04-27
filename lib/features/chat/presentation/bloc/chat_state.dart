import 'package:equatable/equatable.dart';

enum ChatStatus { initial, loading, loaded, sending, error }

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  const ChatMessage({required this.text, required this.isMe, required this.time});
}

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatMessage> messages;
  final String? error;

  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.error,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? messages,
    String? error,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, messages, error];
}
