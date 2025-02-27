import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';

class ChatModel {
  final String id;
  final List<String> participants;
  final int unreadCount;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final String lastMessageSender;

  ChatModel({
    required this.id,
    required this.participants,
    required this.unreadCount,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSender,
  });

  factory ChatModel.fromJson(String id, Map<String, dynamic> json) {
    return ChatModel(
      id: id,
      participants: List<String>.from(json['participants']),
      unreadCount: json['unreadCount'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
      lastMessageSender: json['lastMessageSender'],
    );
  }

  Chat toEntity() {
    return Chat(
      id: id,
      participants: participants,
      unreadCount: unreadCount,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime.toDate(),
      lastMessageSender: lastMessageSender,
    );
  }
}
