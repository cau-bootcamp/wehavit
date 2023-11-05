import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String home = '/';
  static const String auth = '/auth';
  static const String profile = '/profile';
  static const String myPage = '/myPage';
  static const String addResolution = '/addResolution';
  static const String testPage = '/testPage';
  static const String waitingRoom = '/waitingRoom';
  static const String liveWriting = '$waitingRoom/liveWriting';
  static const String swipeView = '/swipeView';
}
