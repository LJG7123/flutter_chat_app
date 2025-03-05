import 'dart:io';

abstract interface class ImageRepository {
  Future<void> uploadProfileImage(String userId, File file);

  Future<String> getProfileImageUrl(String userId);
}