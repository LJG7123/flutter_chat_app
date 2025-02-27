import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/date_time_util.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListItem extends ConsumerWidget {
  final Chat chat;

  const ChatListItem(this.chat, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = 'me';
    final otherUserId = chat.participants.firstWhere((element) => element != userId);

    return ListTile(
      title: Text(otherUserId),
      subtitle: Text(chat.lastMessage ?? ''),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 4,
        children: [
          Text(chat.lastMessageTime?.toTimeOrDate() ?? ''),
          Badge.count(
            count: chat.unreadCount,
            isLabelVisible: chat.lastMessageSender != userId && chat.unreadCount > 0,
          ),
        ],
      ),
      onTap: () {
        context.push('/chatroom/$otherUserId');
      },
    );
  }
}
