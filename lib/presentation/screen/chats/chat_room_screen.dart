import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/user_list_provider.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_message_input.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_message_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomScreen extends ConsumerWidget {
  final String? chatRoomId;
  final String otherUserId;

  const ChatRoomScreen({super.key, this.chatRoomId, required this.otherUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.read(userListProvider.notifier).getUser(otherUserId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: future,
          builder: (context, snapshot) => Text(snapshot.data?.name ?? ''),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageList(
              chatRoomId: chatRoomId,
              future: future,
            ),
          ),
          ChatMessageInput(chatRoomId, otherUserId),
        ],
      ),
    );
  }
}
