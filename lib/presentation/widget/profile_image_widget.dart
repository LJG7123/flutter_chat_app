import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  const ProfileImageWidget({super.key, this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl?.isNotEmpty ?? false
          ? NetworkImage(imageUrl!)
          : null,
      child: imageUrl?.isEmpty ?? true
          ? Icon(Icons.person)
          : null,
    );
  }
}