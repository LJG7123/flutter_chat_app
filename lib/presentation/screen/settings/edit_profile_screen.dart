import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/selected_image_provider.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_button.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_progress_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            child: selectedImage != null ? Image.file(selectedImage) : null,
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ExpandedButton(onPressed: () {
              ref.read(selectedImageProvider.notifier).pickImage(width);
            }, text: '이미지 선택'),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ExpandedProgressButton(onPressed: () async {}, text: '저장'),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
