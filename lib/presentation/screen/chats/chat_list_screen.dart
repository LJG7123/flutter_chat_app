import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/chat_list_provider.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('채팅')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return ChatListItem(chat);
        },
      ),
    );
  }
}
