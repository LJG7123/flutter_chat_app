import 'dart:io';

import 'package:flutter_chat_app/domain/usecase/image_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

final selectedImageProvider =
    StateNotifierProvider.autoDispose<SelectedImageNotifier, File?>((ref) =>
        SelectedImageNotifier(ref.read(imagePickerProvider),
            ref.read(uploadProfileImageUseCase)));

class SelectedImageNotifier extends StateNotifier<File?> {
  final ImagePicker picker;
  final UploadProfileImageUseCase uploadProfileImageUseCase;

  SelectedImageNotifier(this.picker, this.uploadProfileImageUseCase)
      : super(null);

  Future<void> pickImage(double width) async {
    final selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: width,
      imageQuality: 80,
    );

    if (selectedImage != null) {
      state = File(selectedImage.path);
    }
  }

  Future<void> uploadProfileImage(String userId) async {
    final image = state;
    if (image == null) return;

    return uploadProfileImageUseCase(userId, image);
  }
}
