import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/provider/selected_image_provider.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_button.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_progress_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final selectedImage = ref.watch(selectedImageProvider);

    return Scaffold(
      appBar: AppBar(title: Text('프로필 편집')),
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: width,
            child: selectedImage != null
                ? Image.file(selectedImage)
                : ref.read(authProvider).value?.imageUrl != null
                    ? Image.network(ref.read(authProvider).value!.imageUrl!)
                    : null,
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ExpandedButton(
              onPressed: () {
                ref.read(selectedImageProvider.notifier).pickImage(width);
              },
              text: '이미지 선택',
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ExpandedProgressButton(
              onPressed: () => _saveProfileImage(context, ref),
              text: '저장',
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Future<void> _saveProfileImage(BuildContext context, WidgetRef ref) async {
    if (ref.read(selectedImageProvider) == null) {
      _showSnackBar(context, '이미지가 선택되지 않았습니다.');
      return;
    }

    final userId = ref.read(authProvider).value?.id;
    if (userId == null) {
      _showSnackBar(context, '오류가 발생했습니다.');
      return;
    }

    await ref.read(selectedImageProvider.notifier).uploadProfileImage(userId);
    if (context.mounted) {
      ref.read(authProvider.notifier).reloadProfileImage();
      context.pop();
      _showSnackBar(context, '프로필 사진이 변경되었습니다.');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
