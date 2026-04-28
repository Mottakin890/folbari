import 'package:equatable/equatable.dart';

import 'package:folbari/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;
  final String? targetUserId;
  final bool isAdmin;
  const SendMessage(this.message, {this.targetUserId, this.isAdmin = false});
  @override
  List<Object?> get props => [message, targetUserId, isAdmin];
}

class LoadMessages extends ChatEvent {
  final String? targetUserId;
  const LoadMessages({this.targetUserId});
  @override
  List<Object?> get props => [targetUserId];
}

class UpdateMessages extends ChatEvent {
  final List<ChatMessageEntity> entities;
  const UpdateMessages(this.entities);
  @override
  List<Object?> get props => [entities];
}
