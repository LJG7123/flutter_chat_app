import 'package:flutter_chat_app/data/datasource/auth_data_source.dart';
import 'package:flutter_chat_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<String?> signIn(String email, String password) async {
    final user = await _dataSource.signIn(email, password);
    return user?.uid;
  }

  @override
  String? getCurrentUser() {
    final user = _dataSource.getCurrentUser();
    return user?.uid;
  }
}