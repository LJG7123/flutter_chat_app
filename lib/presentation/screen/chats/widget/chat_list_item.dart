import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/date_time_util.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListItem extends ConsumerWidget {
  final Chat chat;

  const ChatListItem(this.chat, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = User(id: 'me', email: 'test@test.com', name: 'me', age: 20, gender: Gender.male, isReceptionAllowed: true);

    return ListTile(
      title: Text(chat.participants.firstWhere((element) => element != me.id)),
      subtitle: Text(chat.lastMessage ?? ''),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 4,
        children: [
          Text(chat.lastMessageTime?.toTimeOrDate() ?? ''),
          Badge.count(
            count: chat.unreadCount,
            isLabelVisible: chat.lastMessageSender != me.id && chat.unreadCount > 0,
          ),
        ],
      ),
    );
  }
}
