import 'dart:async';

import 'package:flutter_chat_app/domain/entity/message.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessageProvider = StateNotifierProvider.autoDispose
    .family<ChatMessageNotifier, List<Message>, String?>(
  (ref, chatRoomId) => ChatMessageNotifier(
    chatRoomId,
    ref.read(getMessagesUseCaseProvider),
    ref.read(createChatUseCaseProvider),
    ref.read(sendMessageUseCaseProvider),
    ref.read(clearUnreadCountUseCaseProvider),
  ),
);

class ChatMessageNotifier extends StateNotifier<List<Message>> {
  final String? chatRoomId;
  final GetMessagesUseCase getMessagesUseCase;
  final CreateChatUseCase createChatUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final ClearUnreadCountUseCase clearUnreadCountUseCase;
  StreamSubscription? _subscription;

  ChatMessageNotifier(
    this.chatRoomId,
    this.getMessagesUseCase,
    this.createChatUseCase,
    this.sendMessageUseCase,
    this.clearUnreadCountUseCase,
  ) : super([]) {
    _fetchMessages();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _fetchMessages() {
    _subscription?.cancel();
    if (chatRoomId == null) {
      state = [];
      return;
    }

    _subscription = getMessagesUseCase(chatRoomId!).listen(
      (event) {
        state = event;
      },
    );
  }

  Future<String?> sendMessage(
      String senderId, String otherUserId, String content) async {
    String? chatId;

    if (content.isNotEmpty) {
      chatId = chatRoomId ?? await createChatUseCase(senderId, otherUserId);

      await sendMessageUseCase(chatId, senderId, content);
    }

    return chatId;
  }

  Future<void> clearUnreadCount(String userId) async {
    if (chatRoomId == null || state.isEmpty) return;

    if (userId != state.first.senderId) {
      clearUnreadCountUseCase(chatRoomId!);
    }
  }
}
