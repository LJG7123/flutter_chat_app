import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = StateNotifierProvider<UserListNotifier, List<User>>(
    (ref) => UserListNotifier());

class UserListNotifier extends StateNotifier<List<User>> {
  UserListNotifier()
      : super([
          User(id: '0', email: 'test1@gmail.com', name: 'user1', age: 20, gender: Gender.male, isReceptionAllowed: true),
          User(id: '1', email: 'test2@gmail.com', name: 'user2', age: 30, gender: Gender.female, isReceptionAllowed: false),
          User(id: '2', email: 'test3@gmail.com', name: 'user3', age: 40, gender: Gender.male, isReceptionAllowed: true),
        ]) {
    sortWithReceptionAllowed();
  }

  void sortWithReceptionAllowed() {
    var newList = List<User>.from(state);
    newList.sort((a, b) => b.isReceptionAllowed == a.isReceptionAllowed
        ? 0 : a.isReceptionAllowed ? -1 : 1);

    state = newList;
  }
}
