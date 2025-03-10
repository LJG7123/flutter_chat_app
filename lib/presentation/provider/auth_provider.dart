import 'package:flutter_chat_app/core/notification/notification_manager.dart';
import 'package:flutter_chat_app/core/util/validator.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/usecase/auth_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/image_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
    (ref) => AuthNotifier(
          ref.read(signInUseCaseProvider),
          ref.read(signUpUseCaseProvider),
          ref.read(signOutUseCaseProvider),
          ref.read(getCurrentUserUseCaseProvider),
          ref.read(getProfileImageUrlUseCase),
          ref.read(isEmailAvailableUseCaseProvider),
          ref.read(updateTokenUseCaseProvider),
          ref.read(setReceptionAllowedUseCaseProvider),
          ref.read(notificationProvider.notifier),
        ));

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetProfileImageUrlUseCase getProfileImageUrlUseCase;
  final IsEmailAvailableUseCase isEmailAvailableUseCase;
  final UpdateTokenUseCase updateTokenUseCase;
  final SetReceptionAllowedUseCase setReceptionAllowedUseCase;
  final NotificationNotifier notification;

  AuthNotifier(
    this.signInUseCase,
    this.signUpUseCase,
    this.signOutUseCase,
    this.getCurrentUserUseCase,
    this.getProfileImageUrlUseCase,
    this.isEmailAvailableUseCase,
    this.updateTokenUseCase,
    this.setReceptionAllowedUseCase,
    this.notification,
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
    updateTokenUseCase(await notification.getFcmToken());
  }

  Future<void> signUp(String email, String password, DateTime dob, String name,
      String gender) async {
    await signUpUseCase(email, password, dob, name, gender);
    await signIn(email, password);
  }

  Future<void> signOut() async {
    updateTokenUseCase(null);
    await signOutUseCase();
    state = AsyncData(null);
  }

  Future<void> setReceptionAllowed(bool value) async {
    if (value) {
      updateTokenUseCase(await notification.getFcmToken());
    } else {
      updateTokenUseCase(null);
    }
    await setReceptionAllowedUseCase(value);
    return _getCurrentUser();
  }

  void reloadProfileImage() async {
    final user = state.value;
    if (user == null) return;

    final imageUrl = await getProfileImageUrlUseCase(user.id);
    state = AsyncData(user.copyWith(imageUrl: imageUrl));
  }

  Future<bool> isEmailAvailable(String email) async {
    if (!Validator.isEmailValid(email)) return false;
    return isEmailAvailableUseCase(email);
  }

  bool isPasswordAvailable(String password) {
    return Validator.isPasswordValid(password);
  }

  bool isDoBAvailable(String dob) {
    return Validator.isDoBValid(dob);
  }
}
