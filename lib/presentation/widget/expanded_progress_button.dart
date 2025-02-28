import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandedProgressButton extends ConsumerWidget {
  final AsyncCallback onPressed;
  final String text;
  final _isLoadingProvider = StateProvider<bool>((ref) => false);

  ExpandedProgressButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(_isLoadingProvider);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : () => _onButtonPressed(ref),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(8),
          backgroundColor: Colors.transparent,
        ),
        child: isLoading
            ? SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : Text(text),
      ),
    );
  }

  void _onButtonPressed(WidgetRef ref) async {
    ref.read(_isLoadingProvider.notifier).state = true;
    await onPressed();
    ref.read(_isLoadingProvider.notifier).state = false;
  }
}
