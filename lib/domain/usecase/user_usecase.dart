import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/repository/image_repository.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;
  final ImageRepository _imageRepository;

  GetUsersUseCase(this._userRepository, this._imageRepository);

  Future<List<User>> call() async {
    final users = await _userRepository.getUsers();

    return Future.wait(users.map((e) async {
      final url = await _imageRepository.getProfileImageUrl(e.id);
      return e.copyWith(imageUrl: url);
    }));
  }
}

class GetUserUseCase {
  final UserRepository _userRepository;
  final ImageRepository _imageRepository;

  GetUserUseCase(this._userRepository, this._imageRepository);

  Future<User?> call(String userId) async {
    final [User? user, String url] = await Future.wait<dynamic>([
      _userRepository.getUser(userId),
      _imageRepository.getProfileImageUrl(userId),
    ]);

    return user?.copyWith(imageUrl: url);
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