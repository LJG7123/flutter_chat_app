import 'package:flutter_chat_app/domain/entity/user.dart';

abstract interface class UserRepository {
  Future<List<User>> getUsers();

  Future<User?> getUser(String userId);
}