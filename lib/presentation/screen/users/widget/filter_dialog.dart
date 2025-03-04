import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/presentation/widget/general_text_field.dart';
import 'package:go_router/go_router.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  Set<Gender> selection = {};
  final _textControllers = List.generate(2, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('유저 필터'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            spacing: 8,
            children: [
              Text('나이'),
              Flexible(
                child: GeneralTextField(
                  controller: _textControllers[0],
                  inputType: TextInputType.number,
                  padding: EdgeInsets.all(8),
                  isDense: true,
                ),
              ),
              Text('~'),
              Flexible(
                child: GeneralTextField(
                  controller: _textControllers[1],
                  inputType: TextInputType.number,
                  padding: EdgeInsets.all(8),
                  isDense: true,
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Text('성별'),
              SegmentedButton(
                segments: Gender.values
                    .map((e) => ButtonSegment(
                          value: e,
                          label: Text(e.label),
                        ))
                    .toList(),
                selected: selection,
                onSelectionChanged: (selected) {
                  setState(() {
                    selection = selected;
                  });
                },
                showSelectedIcon: false,
                multiSelectionEnabled: true,
                emptySelectionAllowed: true,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: context.pop, child: Text('취소')),
        TextButton(onPressed: () {}, child: Text('적용')),
      ],
    );
  }
}
