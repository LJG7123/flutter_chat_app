import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/date_time_util.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/provider/chat_message_provider.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_message_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessageList extends ConsumerWidget {
  final String? chatRoomId;

  const ChatMessageList(this.chatRoomId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatMessageProvider(chatRoomId));
    final userId = ref.read(authProvider).value?.id;

    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final prevMessage = index > 0 ? messages[index - 1] : null;
          final nextMessage = messages.elementAtOrNull(index + 1);

          final showDateDivider = nextMessage == null ||
              !message.sentTime.isDateSame(nextMessage.sentTime);
          final showTimestamp = prevMessage == null ||
              !message.sentTime.isTimeSame(prevMessage.sentTime);
          final isMine = message.senderId == userId;

          return ChatMessageItem(
            message: message,
            showDateDivider: showDateDivider,
            showTimestamp: showTimestamp,
            isMine: isMine,
          );
        },
      ),
    );
  }
}
