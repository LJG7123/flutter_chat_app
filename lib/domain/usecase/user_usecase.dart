import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  Future<List<User>> call() {
    return _repository.getUsers();
  }
}

class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<User?> call(String userId) {
    return _repository.getUser(userId);
  }
}

class IsEmailAvailableUseCase {
  final UserRepository _repository;

  IsEmailAvailableUseCase(this._repository);

  Future<bool> call(String email) {
    return _repository.isEmailAvailable(email);
  }
}