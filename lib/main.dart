import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wehavit/common/utils/shared_prefs.dart';

import 'common/observers.dart';
import 'firebase_options.dart';
import 'main/app.dart';

Future<void> main() async {
  // ignore: avoid_redundant_argument_values
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ko');
  await Future.wait([
    SharedPrefs.init(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);

  runApp(
    ProviderScope(
      observers: [Observers()],
      child: const MyApp(),
    ),
  );
}
