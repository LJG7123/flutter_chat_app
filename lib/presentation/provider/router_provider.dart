import 'package:flutter_chat_app/presentation/screen/chats/chat_room_screen.dart';
import 'package:flutter_chat_app/presentation/screen/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/chatroom/:id',
        builder: (context, state) {
          final otherUserId = state.pathParameters['id'] ?? '';
          return ChatRoomScreen(otherUserId: otherUserId);
        },
      )
    ],
  );
});
