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
      )
    ],
  );
});
