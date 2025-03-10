import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/auth_repository.dart';
import 'package:flutter_chat_app/domain/repository/image_repository.dart';
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

class SignUpUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignUpUseCase(this._authRepository, this._userRepository);

  Future<void> call(String email, String password, DateTime dob, String name,
      String gender) async {
    final uid = await _authRepository.signUp(email, password);
    if (uid == null) return;

    return _userRepository.createUser(uid, email, name, dob, gender);
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
  final ImageRepository _imageRepository;

  GetCurrentUserUseCase(
      this._authRepository, this._userRepository, this._imageRepository);

  Future<User?> call() async {
    final uid = _authRepository.getCurrentUser();
    if (uid == null) return null;

    final user = await _userRepository.getUser(uid);
    final url = await _imageRepository.getProfileImageUrl(uid);

    return user?.copyWith(imageUrl: url);
  }
}

class UpdateTokenUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  UpdateTokenUseCase(this._authRepository, this._userRepository);

  Future<void> call(String? token) async {
    final uid = _authRepository.getCurrentUser();
    if (uid == null) return;

    return _userRepository.updateToken(uid, token);
  }
}

class SetReceptionAllowedUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SetReceptionAllowedUseCase(this._authRepository, this._userRepository);

  Future<void> call(bool value) async {
    final uid = _authRepository.getCurrentUser();
    if (uid == null) return;

    return _userRepository.updateReceptionAllowed(uid, value);
  }
}