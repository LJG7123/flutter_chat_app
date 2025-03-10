import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat_app/presentation/provider/router_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends StateNotifier<StreamSubscription?> {
  final channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final Ref ref;

  NotificationNotifier(this.ref) : super(null) {
    setupInteractedMessage();
    setupForegroundMessage();
    listenForegroundMessage();
  }

  @override
  void dispose() {
    state?.cancel();
    super.dispose();
  }

  Future<void> setupInteractedMessage() async {
    /// 백그라운드 알림
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> setupForegroundMessage() async {
    /// 포그라운드 알림
    var iOSInitializationSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
    );
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (detail) {
      final payload = detail.payload;
      if (payload == null) return;
      if (ref
          .read(routerProvider)
          .state
          .matchedLocation
          .contains('/chatroom')) {
        return;
      }

      final data = jsonDecode(payload);
      ref.read(routerProvider).push('/chatroom', extra: {
        'chatRoomId': data['chatRoomId'],
        'otherUserId': data['otherUserId'],
      });
    });
  }

  void listenForegroundMessage() {
    state = FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        final routerState = ref.read(routerProvider).state;
        if (routerState.matchedLocation == '/chatroom' &&
            message.data['chatRoomId'] ==
                (routerState.extra as Map<String, dynamic>)['chatRoomId']) {
          return;
        }
        flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: channel.importance,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  void cancelForegroundMessage() async {
    await state?.cancel();
    state = null;
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      ref.read(routerProvider).push('/chatroom', extra: {
        'chatRoomId': message.data['chatRoomId'],
        'otherUserId': message.data['otherUserId'],
      });
    }
  }

  Future<String?> getFcmToken() {
    return FirebaseMessaging.instance.getToken();
  }
}
