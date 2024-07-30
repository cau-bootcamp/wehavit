// ignore_for_file: avoid_redundant_argument_values, lines_longer_than_80_chars

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wehavit/firebase_options.dart';
import 'package:wehavit/presentation/reaction/reaction.dart';

/// 알림 권한 요청 및 푸쉬 알림으로 앱 진입 시 라우팅을 처리하는 로직
///
Future<String?> setFirebaseCloudMessaging(
  GlobalKey reactionWidgetChildKey,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // background 관련 처리가 필요한 경우에는 아래줄 코드의 주석을 풀고
  // 파일 최하단의 _firebaseMessagingBackgroundHandler 함수를 콜백으로 전달하기.
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
  debugPrint('사용자에게서 알림 허가를 받음 : ${settings.authorizationStatus}');

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.ios) {
    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'wehavit_notification',
    //   'wehavit_notification',
    //   description: 'wehavit의 알림입니다',
    //   importance: Importance.low,
    // );

    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    messaging.getInitialMessage().then((RemoteMessage? message) {
      // 처음에 앱 실행했을 때 들어와있는 메시지가 있을 때 처리하는 로직
      // 위해빗의 경우에는 앱 실행 시 reaction을 load 하는 로직이 이미 있기 때문에 괜찮음
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      (reactionWidgetChildKey as GlobalKey<ReactionAnimationWidgetState>)
          .currentState
          ?.showUnreadReactions();
    });

    // background 상태. Notification 서랍에서 메시지 터치하여 앱으로 돌아왔을 때의 동작은 여기서.
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print("DEBUG : listen0");
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification? notification = message.notification;

      (reactionWidgetChildKey as GlobalKey<ReactionAnimationWidgetState>)
          .currentState
          ?.showUnreadReactions();
    });
  } else if (DefaultFirebaseOptions.currentPlatform ==
      DefaultFirebaseOptions.android) {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'wehavit_notification',
      'wehavit_notification',
      description: 'wehavit의 알림입니다',
      importance: Importance.low,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    messaging.getInitialMessage().then((RemoteMessage? message) {
      // 처음에 앱 실행했을 때 들어와있는 메시지가 있을 때 처리하는 로직
      // 위해빗의 경우에는 앱 실행 시 reaction을 load 하는 로직이 이미 있기 때문에 괜찮음
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      (reactionWidgetChildKey as GlobalKey<ReactionAnimationWidgetState>)
          .currentState
          ?.showUnreadReactions();
    });

    // background 상태. Notification 서랍에서 메시지 터치하여 앱으로 돌아왔을 때의 동작은 여기서.
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print("DEBUG : listen0");
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification? notification = message.notification;

      (reactionWidgetChildKey as GlobalKey<ReactionAnimationWidgetState>)
          .currentState
          ?.showUnreadReactions();
    });
  }

  // 실기기 테스트 시에 이 토큰 값을 활용해주면 됨
  String? firebaseToken = await FirebaseMessaging.instance.getToken();
  debugPrint('firebase token : $firebaseToken');

  return firebaseToken;
}

/// 앱이 종료상태일 때 알림을 눌러 앱에 진입한 경우에 대해 처리하는 로직
/// 현재는 종료상태일 때 앱 푸쉬로 들어오면 따로 이동하는 페이자가 없으므로,
Future<void> setTerminatedStateMessageHandler() async {
  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.ios) {
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {}
  } else if (DefaultFirebaseOptions.currentPlatform ==
      DefaultFirebaseOptions.android) {
    //
  }
}

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  // await Firebase.initializeApp();
  print('DEBUG : receive message in background mode');
}
