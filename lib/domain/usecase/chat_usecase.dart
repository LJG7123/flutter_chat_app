import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/message.dart';
import 'package:flutter_chat_app/domain/repository/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository _repository;

  GetChatsUseCase(this._repository);

  Stream<List<Chat>> call(String userId) {
    return _repository.getChats(userId);
  }
}

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  Stream<List<Message>> call(String chatRoomId) {
    return _repository.getMessages(chatRoomId);
  }
}

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Future<void> call(String chatRoomId, String senderId, String content) {
    return _repository.sendMessage(chatRoomId, senderId, content);
  }
}