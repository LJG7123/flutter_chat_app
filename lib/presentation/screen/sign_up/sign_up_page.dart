import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widget/general_text_field.dart';
import 'package:flutter_chat_app/presentation/widget/obscure_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  final TextEditingController controller;
  final String title;
  final String subTitle;
  final String? hintText;
  final StateProvider<String?>? errorProvider;
  final TextInputType? inputType;
  final bool obscureText;

  const SignUpPage({
    required this.controller,
    required this.title,
    required this.subTitle,
    this.hintText,
    this.errorProvider,
    this.inputType,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = errorProvider != null ? ref.watch(errorProvider!) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 22)),
        SizedBox(height: 12),
        Text(subTitle, style: TextStyle(fontSize: 14)),
        SizedBox(height: 36),
        obscureText
            ? ObscureTextField(
                controller: controller,
                hintText: hintText,
                errorText: errorText,
              )
            : GeneralTextField(
                controller: controller,
                hintText: hintText,
                errorText: errorText,
                inputType: inputType,
              ),
      ],
    );
  }
}
