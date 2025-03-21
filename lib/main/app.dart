import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: discarded_futures
      setFirebaseCloudMessaging(ref.watch(reactionAnimationWidgetKeyProvider));
      // ignore: discarded_futures
      setTerminatedStateMessageHandler();
    });

    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
    unawaited(dismissSplash());
  }

  Future<void> dismissSplash() async {
    // ignore: unused_local_variable
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntranceView(),
      theme: WehavitTheme.defaultTheme,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/main':
            builder = (context) => const MainView();
            break;
          case '/entrance':
            builder = (context) => const EntranceView();
            break;
          default:
            throw Exception('Invalid Route : ${settings.name}');
        }
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      },
    );
  }
}
