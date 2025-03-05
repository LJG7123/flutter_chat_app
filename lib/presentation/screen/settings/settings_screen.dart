import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: IconButton(
                  onPressed: () {
                    context.push('/edit_profile');
                  },
                  padding: EdgeInsets.zero,
                  icon: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 12,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user?.name ?? ''),
                  Text(user?.email ?? '', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
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
