import 'package:flutter_chat_app/domain/entity/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessageProvider =
    StateNotifierProvider<ChatMessageNotifier, List<Message>>(
        (ref) => ChatMessageNotifier());

class ChatMessageNotifier extends StateNotifier<List<Message>> {
  ChatMessageNotifier()
      : super([
          Message(
              id: '',
              senderId: 'me',
              content: 'hi',
              sentTime: DateTime(2025, 02, 27)),
          Message(
              id: '',
              senderId: '0',
              content: 'hello',
              sentTime: DateTime.now()),
        ]);
}
