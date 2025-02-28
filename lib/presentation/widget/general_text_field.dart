import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final TextInputType? inputType;

  const GeneralTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
