import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/domain/entity/message.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String content;
  final Timestamp sentTime;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.sentTime,
  });

  factory MessageModel.fromJson(String id, Map<String, dynamic> json) {
    return MessageModel(
      id: id,
      senderId: json['senderId'],
      content: json['content'],
      sentTime: json['sentTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'content': content,
      'sentTime': sentTime,
    };
  }

  Message toEntity() {
    return Message(
      id: id,
      senderId: senderId,
      content: content,
      sentTime: sentTime.toDate(),
    );
  }
}
