import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_chat_app/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = StateNotifierProvider<UserListNotifier, List<User>>(
    (ref) => UserListNotifier(ref.read(getUsersUseCaseProvider)));

class UserListNotifier extends StateNotifier<List<User>> {
  final GetUsersUseCase getUsersUseCase;

  UserListNotifier(this.getUsersUseCase)
      : super([]) {
    _fetchAllUsers();
  }

  void _fetchAllUsers() async {
    final users = await getUsersUseCase();

    state = sortWithReceptionAllowed(users);
  }

  List<User> sortWithReceptionAllowed(List<User> users) {
    var newList = List<User>.from(users);
    newList.sort((a, b) => b.isReceptionAllowed == a.isReceptionAllowed
        ? 0 : a.isReceptionAllowed ? -1 : 1);

    return newList;
  }
}
