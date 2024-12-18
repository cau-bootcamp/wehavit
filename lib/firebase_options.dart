// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC9ZxMvb21D_3Jdf0FzlG8UsmrlL2gDacY',
    appId: '1:764897522660:web:ddd978b027d2fff6b1cdf1',
    messagingSenderId: '764897522660',
    projectId: 'we-havit-be',
    authDomain: 'we-havit-be.firebaseapp.com',
    databaseURL: 'https://we-havit-be-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'we-havit-be.appspot.com',
    measurementId: 'G-707T7ETWGP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCE5n-Nv6H8SFri1wJBMOeLZ_AXEFq_-Y4',
    appId: '1:764897522660:android:39b6b251ac1924feb1cdf1',
    messagingSenderId: '764897522660',
    projectId: 'we-havit-be',
    databaseURL: 'https://we-havit-be-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'we-havit-be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpEgnUEQs27KjI8pJaypqaTlYzmRkhIa4',
    appId: '1:764897522660:ios:b0a95f48091a963db1cdf1',
    messagingSenderId: '764897522660',
    projectId: 'we-havit-be',
    databaseURL: 'https://we-havit-be-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'we-havit-be.appspot.com',
    androidClientId: '764897522660-88jtfk0rhihjcduu4dfjqm0a0nuqdlei.apps.googleusercontent.com',
    iosClientId: '764897522660-njq584kfil0otf92p4ujml8b6b5pegj9.apps.googleusercontent.com',
    iosBundleId: 'com.bootcamp.wehavit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpEgnUEQs27KjI8pJaypqaTlYzmRkhIa4',
    appId: '1:764897522660:ios:48a083e63cc55893b1cdf1',
    messagingSenderId: '764897522660',
    projectId: 'we-havit-be',
    databaseURL: 'https://we-havit-be-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'we-havit-be.appspot.com',
    androidClientId: '764897522660-88jtfk0rhihjcduu4dfjqm0a0nuqdlei.apps.googleusercontent.com',
    iosClientId: '764897522660-ollgi4mmng0b687sussgeu9hpjd4891d.apps.googleusercontent.com',
    iosBundleId: 'com.bootcamp.wehavit.RunnerTests',
  );
}
