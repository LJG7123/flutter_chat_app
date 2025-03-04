import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/date_time_util.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/provider/user_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListItem extends ConsumerWidget {
  final Chat chat;

  const ChatListItem(this.chat, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authProvider).value?.id;
    final otherUserId =
        chat.participants.firstWhere((element) => element != userId);

    return ListTile(
      title: FutureBuilder(
        future: ref.read(userListProvider.notifier).getUser(otherUserId),
        builder: (context, snapshot) => Text(snapshot.data?.name ?? ''),
      ),
      subtitle: Text(chat.lastMessage ?? ''),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 4,
        children: [
          Text(chat.lastMessageTime?.toTimeOrDate() ?? ''),
          Badge.count(
            count: chat.unreadCount,
            isLabelVisible:
                chat.lastMessageSender != userId && chat.unreadCount > 0,
          ),
        ],
      ),
      onTap: () {
        context.push('/chatroom', extra: {
          'chatRoomId': chat.id,
          'otherUserId': otherUserId,
        });
      },
    );
  }
}
