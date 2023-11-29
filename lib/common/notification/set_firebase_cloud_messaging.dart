// ignore_for_file: avoid_redundant_argument_values

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/common/routers/route_provider.dart';
import 'package:wehavit/firebase_options.dart';

/// 알림 권한 요청 및 푸쉬 알림으로 앱 진입 시 라우팅을 처리하는 로직
///
Future<String?> setFirebaseCloudMessaging(BuildContext context) async {
  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.ios) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // background 관련 처리가 필요한 경우에는 아래줄 코드의 주석을 풀고
    // 파일 최하단의 _firebaseMessagingBackgroundHandler 함수를 콜백으로 전달하기.
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      if (message.data['goto'] == 'LiveWaitingView') {
        navigationKey.currentContext!.push(RouteLocation.liveWaitingSampleView);
      } else {
        //
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      // 여기 부분에 코드를 작성하면
      // 알림을 탭하지 않더라도, 알림을 받기만 하면 앱이 알림을 읽고 로직을 처리할 수 있음

      // 아래 코드는 안드로이드의 로직으로 생각됨!
      // 안드로이드 구현 시 참고하고, 필요없다면 삭제하기
      // iOS 환경에서는 디버깅 테스트를 하며 한 번도 호출되지 않았음.
      AndroidNotification? android = message.notification?.android;
      if (message.notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
        );
      }
    });
  } else if (DefaultFirebaseOptions.currentPlatform ==
      DefaultFirebaseOptions.ios) {
    // TODO: 안드로이드에서의 알림 처리 여기에 구현하기

    throw UnimplementedError();
  }

  // 실기기 테스트 시에 이 토큰 값을 활용해주면 됨
  String? firebaseToken = await FirebaseMessaging.instance.getToken();
  debugPrint('firebase token : $firebaseToken');

  return firebaseToken;
}

/// 앱이 종료상태일 때 알림을 눌러 앱에 진입한 경우에 대해 처리하는 로직
///
Future<void> setTerminatedStateMessageHandler(WidgetRef ref) async {
  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.ios) {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data['goto'] == 'LiveWaitingView') {
        final routerConfig = ref.watch(routerProvider);
        routerConfig.push(RouteLocation.liveWaitingSampleView);
      }
    }
  } else if (DefaultFirebaseOptions.currentPlatform ==
      DefaultFirebaseOptions.android) {
    // TODO: 안드로이드에서의 앱 종료 시점의 알림 처리 여기에 구현하기
    // iOS의 코드가 안드로이드에서도 동일하게 적용 가능한 지 확인해봐야함!
  }
}

// Future<void> _firebaseMessagingBackgroundHandler(
//   RemoteMessage message, {
// }) async {
//   await Firebase.initializeApp();
// }