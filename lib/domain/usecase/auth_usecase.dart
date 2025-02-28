import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/auth_repository.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignInUseCase(this._authRepository, this._userRepository);

  Future<User?> call(String email, String password) async {
    final uid = await _authRepository.signIn(email, password);
    if (uid == null) return null;

    return _userRepository.getUser(uid);
  }
}

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() {
    return _repository.signOut();
  }
}

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._authRepository, this._userRepository);

  Future<User?> call() async {
    final uid = _authRepository.getCurrentUser();
    if (uid == null) return null;

    return _userRepository.getUser(uid);
  }
}