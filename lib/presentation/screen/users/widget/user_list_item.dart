import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/date_time_util.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/provider/chat_list_provider.dart';
import 'package:flutter_chat_app/presentation/widget/profile_image_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserListItem extends ConsumerWidget {
  final User user;

  const UserListItem(this.user, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(authProvider).value;

    return Opacity(
      opacity: user.isReceptionAllowed ? 1 : 0.5,
      child: ListTile(
        tileColor: user.isReceptionAllowed ? null : Colors.grey[200],
        leading: ProfileImageWidget(imageUrl: user.imageUrl),
        title: Text(user.name),
        subtitle:
            Text('${user.email} / ${user.gender.label} / ${user.dob.toAge()}'),
        onTap: user.id == currentUser?.id
            ? () => _showSnackBar(context, '본인의 아이디입니다.')
            : user.isReceptionAllowed
                ? () => _onListItemClicked(context, ref)
                : () => _showSnackBar(context, '사용자가 수신 거부 상태입니다.'),
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

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
