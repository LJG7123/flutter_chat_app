import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/presentation/provider/chat_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserListItem extends ConsumerWidget {
  final User user;

  const UserListItem(this.user, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 0),
      enabled: !user.isReceptionAllowed,
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        onTap: user.isReceptionAllowed ? () {
          _onListItemClicked(context, ref);
        } : null,
      ),
    );
  }

  void _onListItemClicked(BuildContext context, WidgetRef ref) {
    final chat = ref.read(chatListProvider).cast<Chat?>().firstWhere(
          (element) => element?.participants.contains(user.id) ?? false,
          orElse: () => null,
        );

    context.push('/chatroom', extra: {
      if (chat != null) ...{
        'chatRoomId': chat.id,
      },
      'otherUserId': user.id,
    });
  }
}
