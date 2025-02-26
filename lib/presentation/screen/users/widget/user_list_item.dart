import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 0),
      enabled: !user.isReceptionAllowed,
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
    );
  }
}
