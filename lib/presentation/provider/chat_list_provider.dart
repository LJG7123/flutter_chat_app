import 'dart:async';

import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatListProvider =
    StateNotifierProvider<ChatListNotifier, List<Chat>>(
        (ref) => ChatListNotifier(
              ref,
              ref.read(getChatsUseCaseProvider),
            ));

class ChatListNotifier extends StateNotifier<List<Chat>> {
  final Ref ref;
  final GetChatsUseCase getChatsUseCase;
  StreamSubscription? chatSubscription;

  ChatListNotifier(this.ref, this.getChatsUseCase) : super([]) {
    _fetchAllChats();
  }

  void _fetchAllChats() async {
    ref.listen(
      authProvider.select((async) => async.value), (previous, next) {
        chatSubscription?.cancel();

        final userId = next?.id;
        if (userId == null) {
          state = [];
          return;
        }

        chatSubscription = getChatsUseCase(userId).listen((event) {
          state = event;
        });
      },
    );
  }
}
