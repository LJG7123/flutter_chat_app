import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider =
    StateNotifierProvider.autoDispose<UserListNotifier, List<User>>(
        (ref) => UserListNotifier(
              ref.read(getUsersUseCaseProvider),
              ref.read(getUserUseCaseProvider),
              ref.read(getUsersWithFilterUseCaseProvider),
            ));

class UserListNotifier extends StateNotifier<List<User>> {
  final GetUsersUseCase getUsersUseCase;
  final GetUserUseCase getUserUseCase;
  final GetUsersWithFilterUseCase getUsersWithFilterUseCase;

  UserListNotifier(
      this.getUsersUseCase, this.getUserUseCase, this.getUsersWithFilterUseCase)
      : super([]) {
    _fetchAllUsers();
  }

  void _fetchAllUsers() async {
    final users = await getUsersUseCase();

    state = sortWithReceptionAllowed(users);
  }

  Future<void> filterUsers(int? min, int? max, Set<Gender> genders) async {
    final users = await getUsersWithFilterUseCase(min, max, genders);

    state = sortWithReceptionAllowed(users);
  }

  Future<User?> getUser(String userId) async {
    final user = state.where((e) => e.id == userId).firstOrNull;
    if (user != null) return user;

    return getUserUseCase(userId);
  }

  List<User> sortWithReceptionAllowed(List<User> users) {
    var newList = List<User>.from(users);
    newList.sort((a, b) => b.isReceptionAllowed == a.isReceptionAllowed
        ? 0
        : a.isReceptionAllowed
            ? -1
            : 1);

    return newList;
  }
}
