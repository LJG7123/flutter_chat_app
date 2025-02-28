import 'package:flutter_chat_app/core/util/validator.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/usecase/auth_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
    (ref) => AuthNotifier(
          ref.read(signInUseCaseProvider),
          ref.read(signOutUseCaseProvider),
          ref.read(getCurrentUserUseCaseProvider),
          ref.read(isEmailAvailableUseCaseProvider),
        ));

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsEmailAvailableUseCase isEmailAvailableUseCase;

  AuthNotifier(
    this.signInUseCase,
    this.signOutUseCase,
    this.getCurrentUserUseCase,
    this.isEmailAvailableUseCase,
  ) : super(AsyncLoading()) {
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    final user = await getCurrentUserUseCase();
    state = AsyncData(user);
  }

  Future<void> signIn(String email, String password) async {
    final user = await signInUseCase(email, password);
    state = AsyncData(user);
  }

  Future<void> signOut() async {
    await signOutUseCase();
    state = AsyncData(null);
  }

  Future<bool> isEmailAvailable(String email) async {
    if (!Validator.isEmailValid(email)) return false;
    return isEmailAvailableUseCase(email);
  }

  bool isPasswordAvailable(String password) {
    return Validator.isPasswordValid(password);
  }
}
