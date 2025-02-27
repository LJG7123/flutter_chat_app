import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/repository/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository _repository;

  GetChatsUseCase(this._repository);

  Stream<List<Chat>> call(String userId) {
    return _repository.getChats(userId);
  }
}