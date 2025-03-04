import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/presentation/provider/user_list_provider.dart';
import 'package:flutter_chat_app/presentation/widget/general_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FilterDialog extends ConsumerStatefulWidget {
  const FilterDialog({super.key});

  @override
  ConsumerState<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends ConsumerState<FilterDialog> {
  Set<Gender> selection = {};
  final _textControllers = List.generate(2, (index) => TextEditingController());

  @override
  void dispose() {
    for (var element in _textControllers) {
      element.dispose();
    }
    super.dispose();
  }

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
                  hintText: '최소',
                  isDense: true,
                ),
              ),
              Text('~'),
              Flexible(
                child: GeneralTextField(
                  controller: _textControllers[1],
                  inputType: TextInputType.number,
                  padding: EdgeInsets.all(8),
                  hintText: '최대',
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
        TextButton(onPressed: _applyFilter, child: Text('적용')),
      ],
    );
  }

  void _applyFilter() async {
    int? min = int.tryParse(_textControllers[0].text);
    int? max = int.tryParse(_textControllers[1].text);

    if (min != null && max != null && min > max) {
      _showSnackBar('나이 최소값이 최대값보다 클 수 없습니다.');
      return;
    }

    await ref.read(userListProvider.notifier).filterUsers(min, max, selection);

    if (mounted) {
      context.pop();
      _showSnackBar('필터를 적용했습니다.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
