import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/notification/set_firebase_cloud_messaging.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  final GlobalKey<ReactionAnimationWidgetState> reactionWidgetChildKey =
      GlobalKey<ReactionAnimationWidgetState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: discarded_futures
      setFirebaseCloudMessaging(reactionWidgetChildKey);
      // ignore: discarded_futures
      setTerminatedStateMessageHandler();
    });
  }

  @override
  Widget build(BuildContext context) {
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
