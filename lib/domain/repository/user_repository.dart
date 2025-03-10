import 'package:flutter_chat_app/domain/entity/user.dart';

abstract interface class UserRepository {
  Future<List<User>> getUsers();

  Future<User?> getUser(String userId);

  Future<List<User>> getUsersWithFilter(
      DateTime? min, DateTime? max, Set<Gender> genders);

  Future<void> createUser(
      String userId, String email, String name, DateTime dob, String gender);

  Future<bool> isEmailAvailable(String email);

  Future<void> updateToken(String userId, String? token);

  Future<void> updateReceptionAllowed(String userId, bool value);
}
