import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/notification/set_firebase_cloud_messaging.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    setFirebaseCloudMessaging(context);
    // ignore: discarded_futures
    setTerminatedStateMessageHandler(ref);
  }

  @override
  Widget build(BuildContext context) {
    // final routerConfig = ref.watch(routerProvider);
    // final theme = ref.watch(themeProvider);

    // return ScreenUtilInit(
    //   designSize: const Size(375, 812),
    //   builder: (ctx, child) {
    //     return MaterialApp.router(
    //       debugShowCheckedModeBanner: false,
    //       title: appTitle,
    //       // theme: ThemeData(fontFamily: 'SF-Pro'),
    //       darkTheme: ThemeData.dark(),
    //       themeMode: theme,
    //       routerConfig: routerConfig,
    //     );
    //   },
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntranceView(),
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
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      },
    );
  }
}
