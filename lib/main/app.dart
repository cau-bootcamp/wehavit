import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/notification/fcm_setting.dart';
import 'package:wehavit/common/theme/providers/theme_provider.dart';
import 'package:wehavit/features/live_writing_waiting/live_waiting_sample_view.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fcmSetting(context);
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("From Terminated app state");
      if (initialMessage.data['goto'] == 'LiveWaitingView') {
        print("Accept Go To LiveWaitingView");

        final routerConfig = ref.watch(routerProvider);
        routerConfig.push(RouteLocation.liveWaitingSampleView);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final routerConfig = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (ctx, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: theme,
          routerConfig: routerConfig,
        );
      },
    );
  }
}
