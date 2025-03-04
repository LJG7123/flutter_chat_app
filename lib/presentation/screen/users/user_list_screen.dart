import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/user_list_provider.dart';
import 'package:flutter_chat_app/presentation/screen/users/widget/filter_dialog.dart';
import 'package:flutter_chat_app/presentation/screen/users/widget/user_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('유저')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return UserListItem(user);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFilterDialog(context),
        icon: Icon(Icons.filter_alt),
        label: Text('필터'),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(),
    );
  }
}
