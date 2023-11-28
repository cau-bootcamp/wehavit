import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/notification/fcm_setting.dart';
import 'package:wehavit/common/utils/shared_prefs.dart';

import 'common/observers.dart';
import 'firebase_options.dart';
import 'main/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SharedPrefs.init(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    fcmSetting(),
  ]);
  runApp(
    ProviderScope(
      observers: [Observers()],
      child: const MyApp(),
    ),
  );
}
