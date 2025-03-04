import 'dart:async';

import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatListProvider =
    StateNotifierProvider.autoDispose<ChatListNotifier, List<Chat>>(
        (ref) => ChatListNotifier(
              ref.read(authProvider).value,
              ref.read(getChatsUseCaseProvider),
            ));

class ChatListNotifier extends StateNotifier<List<Chat>> {
  final User? currentUser;
  final GetChatsUseCase getChatsUseCase;
  StreamSubscription? chatSubscription;

  ChatListNotifier(this.currentUser, this.getChatsUseCase) : super([]) {
    _fetchAllChats();
  }

  void _fetchAllChats() async {
    chatSubscription?.cancel();
    final userId = currentUser?.id;
    if (userId == null) return;

    chatSubscription = getChatsUseCase(userId).listen((event) {
      state = event;
    });
  }
}
