import 'package:flutter/material.dart';

class ObscureTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;

  const ObscureTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
  });

  @override
  State<StatefulWidget> createState() => _ObscureTextFieldState();
}

class _ObscureTextFieldState extends State<ObscureTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
