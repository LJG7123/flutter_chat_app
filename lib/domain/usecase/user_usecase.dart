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

class GetUsersWithFilterUseCase {
  final UserRepository _repository;

  GetUsersWithFilterUseCase(this._repository);

  Future<List<User>> call(int? min, int? max, Set<Gender> genders) {
    int nowYear = DateTime.now().year;
    DateTime? minYear = max != null ? DateTime(nowYear - max + 1) : null;
    DateTime? maxYear = min != null ? DateTime(nowYear - min + 1) : null;

    return _repository.getUsersWithFilter(minYear, maxYear, genders);
  }
}

class IsEmailAvailableUseCase {
  final UserRepository _repository;

  IsEmailAvailableUseCase(this._repository);

  Future<bool> call(String email) {
    return _repository.isEmailAvailable(email);
  }
}