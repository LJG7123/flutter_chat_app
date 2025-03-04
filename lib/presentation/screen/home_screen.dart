import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/screen/chats/chat_list_screen.dart';
import 'package:flutter_chat_app/presentation/screen/settings/settings_screen.dart';
import 'package:flutter_chat_app/presentation/screen/users/user_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final _currentIndexProvider = StateProvider<int>((ref) => 0);
  final _pages = <Widget>[
    UserListScreen(),
    ChatListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_currentIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => ref.read(_currentIndexProvider.notifier).state = value,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '유저'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
