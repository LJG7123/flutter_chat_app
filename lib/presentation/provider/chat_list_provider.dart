import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatListProvider = StateNotifierProvider<ChatListNotifier, List<Chat>>(
    (ref) => ChatListNotifier());

class ChatListNotifier extends StateNotifier<List<Chat>> {
  ChatListNotifier() : super([
    Chat(id: '', participants: ['me', '0'], unreadCount: 0, lastMessage: 'hi', lastMessageTime: DateTime(2025,02,25), lastMessageSender: '0'),
    Chat(id: '', participants: ['me', '1'], unreadCount: 1, lastMessage: 'text', lastMessageTime: DateTime(2025,02,26), lastMessageSender: 'me'),
    Chat(id: '', participants: ['me', '2'], unreadCount: 2, lastMessage: 'hello', lastMessageTime: DateTime.now(), lastMessageSender: '2'),
  ]);
}
