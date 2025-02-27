import 'dart:async';

import 'package:flutter_chat_app/domain/entity/message.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessageProvider = StateNotifierProvider.autoDispose
    .family<ChatMessageNotifier, List<Message>, String?>((ref, chatRoomId) =>
        ChatMessageNotifier(chatRoomId, ref.read(getMessagesUseCaseProvider)));

class ChatMessageNotifier extends StateNotifier<List<Message>> {
  final String? chatRoomId;
  final GetMessagesUseCase getMessagesUseCase;
  StreamSubscription? _subscription;

  ChatMessageNotifier(this.chatRoomId, this.getMessagesUseCase)
      : super([]) {
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
}
