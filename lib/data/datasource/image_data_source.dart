import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageDataSource {
  final FirebaseStorage _storage;
  Reference get _storageRef => _storage.ref();

  ImageDataSource(this._storage);

  UploadTask uploadProfileImage(String userId, File file) {
    final ref = _storageRef.child('profile/$userId');
    return ref.putFile(file);
  }

  Future<String> getProfileImageUrl(String userId) {
    final ref = _storageRef.child('profile/$userId');
    return ref.getDownloadURL().catchError((_) => '');
  }
}