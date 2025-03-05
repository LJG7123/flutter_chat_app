import 'dart:io';

import 'package:flutter_chat_app/data/datasource/image_data_source.dart';
import 'package:flutter_chat_app/domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataSource _dataSource;

  ImageRepositoryImpl(this._dataSource);

  @override
  Future<void> uploadProfileImage(String userId, File file) {
    return _dataSource.uploadProfileImage(userId, file);
  }

  @override
  Future<String> getProfileImageUrl(String userId) {
    return _dataSource.getProfileImageUrl(userId);
  }

}