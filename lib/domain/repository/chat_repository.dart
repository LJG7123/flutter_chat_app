import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/message.dart';

abstract interface class ChatRepository {
  Stream<List<Chat>> getChats(String userId);

  Stream<List<Message>> getMessages(String chatRoomId);

  Future<void> sendMessage(String chatRoomId, String senderId, String content);
}