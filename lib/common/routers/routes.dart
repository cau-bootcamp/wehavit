import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/features.dart';

final routes = [
  GoRoute(
    path: RouteLocation.home,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.splash,
    builder: SplashScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.auth,
    builder: AuthScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.friendList,
    builder: FriendListScreen.builder,
  ),
];
