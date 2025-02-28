import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  Future<List<User>> call() {
    return _repository.getUsers();
  }
}

class IsEmailAvailableUseCase {
  final UserRepository _repository;

  IsEmailAvailableUseCase(this._repository);

  Future<bool> call(String email) {
    return _repository.isEmailAvailable(email);
  }
}