import 'dart:io';

import 'package:flutter_chat_app/domain/repository/image_repository.dart';

class UploadProfileImageUseCase {
  final ImageRepository _repository;

  UploadProfileImageUseCase(this._repository);

  Future<void> call(String userId, File file) {
    return _repository.uploadProfileImage(userId, file);
  }
}

class GetProfileImageUrlUseCase {
  final ImageRepository _repository;

  GetProfileImageUrlUseCase(this._repository);

  Future<String?> call(String userId) {
    return _repository.getProfileImageUrl(userId);
  }
}