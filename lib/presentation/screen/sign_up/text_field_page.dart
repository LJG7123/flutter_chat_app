import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/core/util/date_formatter.dart';
import 'package:flutter_chat_app/presentation/widget/general_text_field.dart';
import 'package:flutter_chat_app/presentation/widget/obscure_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldPage extends ConsumerWidget {
  final TextEditingController controller;
  final String title;
  final String subTitle;
  final String? hintText;
  final StateProvider<String?>? errorProvider;
  final TextInputType? inputType;
  final bool obscureText;

  const TextFieldPage({
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
        _buildTextField(errorText),
      ],
    );
  }

  Widget _buildTextField(String? errorText) {
    if (inputType == TextInputType.datetime) {
      return TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          errorText: errorText,
        ),
        inputFormatters: [
          FilteringTextInputFormatter(RegExp('[0-9-]'), allow: true),
          LengthLimitingTextInputFormatter(10),
          DateFormatter(),
        ],
      );
    }
    if (obscureText) {
      return ObscureTextField(
        controller: controller,
        hintText: hintText,
        errorText: errorText,
      );
    }
    return GeneralTextField(
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      inputType: inputType,
    );
  }
}
