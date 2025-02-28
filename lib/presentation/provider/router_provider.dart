import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/screen/chats/chat_room_screen.dart';
import 'package:flutter_chat_app/presentation/screen/home_screen.dart';
import 'package:flutter_chat_app/presentation/screen/sign_in/sign_in_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authLocation = ['/sign_in', '/sign_up'];

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final user = ref.read(authProvider).value;

      if (ref.read(authProvider).isLoading) return null;
      if (user != null && authLocation.contains(state.matchedLocation)) {
        return '/';
      }
      if (user == null && !authLocation.contains(state.matchedLocation)) {
        return '/sign_in';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/chatroom',
        builder: (context, state) {
          final params = state.extra as Map;
          final chatRoomId = params['chatRoomId'];
          final otherUserId = params['otherUserId'] ?? '';

          return ChatRoomScreen(
            chatRoomId: chatRoomId,
            otherUserId: otherUserId,
          );
        },
      ),
      GoRoute(
        path: '/sign_in',
        builder: (context, state) => SignInScreen(),
      ),
    ],
  );

  ref.listen(
    authProvider.select((async) => async.value),
    (previous, next) {
      router.refresh();
    },
  );

  return router;
});
