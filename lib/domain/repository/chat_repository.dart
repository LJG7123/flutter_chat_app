import 'package:flutter_chat_app/domain/entity/chat.dart';

abstract interface class ChatRepository {
  Stream<List<Chat>> getChats(String userId);
}