import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String oldText = oldValue.text;
    String newText = newValue.text;

    if (oldText.length == 3 && newText.length == 4) newText += '-';
    if (oldText.length == 6 && newText.length == 7) newText += '-';
    if (newText.length != 5 && newText.length != 8 && newText.endsWith('-')) {
      newText = oldText;
    }

    return TextEditingValue(text: newText);
  }

}