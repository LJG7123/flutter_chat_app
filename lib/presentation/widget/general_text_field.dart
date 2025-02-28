import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;

  const GeneralTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
