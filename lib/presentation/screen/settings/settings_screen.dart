import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              ref.read(authProvider.notifier).signOut();
            },
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('로그아웃'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
