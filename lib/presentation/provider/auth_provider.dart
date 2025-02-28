import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/usecase/auth_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
    (ref) => AuthNotifier(ref.read(signInUseCaseProvider),
        ref.read(getCurrentUserUseCaseProvider)));

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SignInUseCase signInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthNotifier(this.signInUseCase, this.getCurrentUserUseCase)
      : super(AsyncLoading()) {
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
}
