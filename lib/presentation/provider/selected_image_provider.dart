import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

final selectedImageProvider =
    StateNotifierProvider.autoDispose<SelectedImageNotifier, File?>(
        (ref) => SelectedImageNotifier(ref.read(imagePickerProvider)));

class SelectedImageNotifier extends StateNotifier<File?> {
  final ImagePicker _picker;

  SelectedImageNotifier(this._picker) : super(null);

  Future<void> pickImage(double width) async {
    final selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: width,
      imageQuality: 80,
    );

    if (selectedImage != null) {
      state = File(selectedImage.path);
    }
  }
}
