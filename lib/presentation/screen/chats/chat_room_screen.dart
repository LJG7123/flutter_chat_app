import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_message_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomScreen extends ConsumerWidget {
  final String otherUserId;

  const ChatRoomScreen({super.key, required this.otherUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(otherUserId)),
      body: Column(
        children: [
          Expanded(child: ChatMessageList()),

        ],
      ),
    );
  }
}
