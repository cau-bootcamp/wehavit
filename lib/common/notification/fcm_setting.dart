import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/common/routers/route_provider.dart';
import 'package:wehavit/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message, {
  BuildContext? context,
}) async {
  print("INIT");
  await Firebase.initializeApp();

  debugPrint('Handling background message here : ${message.messageId}');

  if (message.data['goto'] == 'LiveWaitingView') {
    print("Accept Go To LiveWaitingView");
    navigationKey.currentContext!.push(RouteLocation.liveWaitingSampleView);
  }
}

Future<String?> fcmSetting(BuildContext context) async {
  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.ios) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('사용자에게서 알림 허가를 받음 : ${settings.authorizationStatus}');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'wehavit_notification',
      'wehavit_notification',
      description: 'wehavit의 알림입니다',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // background 상태. Notification 서랍에서 메시지 터치하여 앱으로 돌아왔을 때의 동작은 여기서.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message Tapped : ${message.data}");
      if (message.data['goto'] == 'LiveWaitingView') {
        print("Accept Go To LiveWaitingView");
        navigationKey.currentContext!.push(RouteLocation.liveWaitingSampleView);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print("Foregroud에서 메시지를 받음 : ${message.data}");

      if (message.notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon),
          ),
        );

        print("Message에 다음의 notification이 포함되어있음 : ${message.notification}");
      }
    });

    String? firebaseToken = await messaging.getToken();
    print('firebase token : $firebaseToken');

    return firebaseToken;
  }

  throw UnimplementedError();
}
