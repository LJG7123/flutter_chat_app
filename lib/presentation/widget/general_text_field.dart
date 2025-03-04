import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final TextInputType? inputType;
  final EdgeInsets? padding;
  final bool? isDense;

  const GeneralTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
    this.inputType,
    this.padding,
    this.isDense,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: isDense,
        contentPadding: padding,
        hintText: hintText,
        errorText: errorText,
      ),
      inputFormatters: [
        if (inputType == TextInputType.number) ...[
          FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
        ],
      ],
    );
  }
}
