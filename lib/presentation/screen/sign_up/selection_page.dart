import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';

class SelectionPage extends StatefulWidget {
  final void Function(String?) onChanged;

  const SelectionPage({super.key, required this.onChanged});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String _selectedGender = Gender.values.first.label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('성별 선택', style: TextStyle(fontSize: 22)),
        SizedBox(height: 12),
        Text('회원님의 성별을 선택해 주세요.', style: TextStyle(fontSize: 14)),
        SizedBox(height: 36),
        DropdownButton<String>(
          value: _selectedGender,
          items: Gender.values
              .map((e) => DropdownMenuItem(
                    value: e.label,
                    child: Text(e.label),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
