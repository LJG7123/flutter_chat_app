import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_message_input.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_message_list.dart';

class ChatRoomScreen extends StatelessWidget {
  final String? chatRoomId;
  final String otherUserId;

  const ChatRoomScreen({super.key, this.chatRoomId, required this.otherUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(otherUserId)),
      body: Column(
        children: [
          Expanded(child: ChatMessageList(chatRoomId)),
          ChatMessageInput(chatRoomId),
        ],
      ),
    );
  }
}
