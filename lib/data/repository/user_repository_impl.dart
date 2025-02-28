import 'package:flutter_chat_app/data/datasource/user_data_source.dart';
import 'package:flutter_chat_app/data/model/user_model.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<User>> getUsers() async {
    final snapshot = await _dataSource.getUsers();

    return snapshot
        .map((doc) => UserModel.fromJson(doc.id, doc.data()).toEntity())
        .toList();
  }

  @override
  Future<User?> getUser(String userId) async {
    final snapshot = await _dataSource.getUser(userId);
    if (!snapshot.exists) return null;
    final model = UserModel.fromJson(snapshot.id, snapshot.data()!);

    return model.toEntity();
  }

  @override
  Future<bool> isEmailAvailable(String email) async {
    final snapshot = await _dataSource.getEmailCount(email);

    return snapshot.count == 0;
  }
}
