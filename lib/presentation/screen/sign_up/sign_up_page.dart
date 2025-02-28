import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget body;

  const SignUpPage({
    required this.title,
    required this.subTitle,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 22)),
        SizedBox(height: 12),
        Text(subTitle, style: TextStyle(fontSize: 14)),
        SizedBox(height: 36),
        body,
      ],
    );
  }
}
