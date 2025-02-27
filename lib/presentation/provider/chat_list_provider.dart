import 'dart:async';

import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatListProvider = StateNotifierProvider<ChatListNotifier, List<Chat>>(
    (ref) => ChatListNotifier(ref.read(getChatsUseCaseProvider)));

class ChatListNotifier extends StateNotifier<List<Chat>> {
  final GetChatsUseCase getChatsUseCase;
  StreamSubscription? chatSubscription;

  ChatListNotifier(this.getChatsUseCase)
      : super([]) {
    _fetchAllChats();
  }

  void _fetchAllChats() async {
    chatSubscription?.cancel();
    final userId = 'me';

    chatSubscription = getChatsUseCase(userId).listen((event) {
      state = event;
    });
  }
}
