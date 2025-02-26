import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  Future<List<User>> call() {
    return _repository.getUsers();
  }
}