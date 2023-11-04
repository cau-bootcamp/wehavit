import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/routers/error_screen.dart';
import 'package:wehavit/common/routers/route_location.dart';
// import 'package:wehavit/common/routers/routes.dart';
import 'package:wehavit/features/features.dart';
import 'package:wehavit/features/my_page/presentation/screens/add_resolution_screen.dart';
import 'package:wehavit/features/my_page/presentation/screens/my_page_screen.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/swipe_view.dart';

part 'route_provider.g.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    // final authState = ref.watch(authStateChangesProvider);

    return GoRouter(
      // initialLocation: RouteLocation.splash,
      initialLocation: RouteLocation.swipeView,
      navigatorKey: navigationKey,
      debugLogDiagnostics: true,
      routes: $appRoutes,
      errorBuilder: (context, state) => const ErrorScreen(),
    );
  },
);

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  static const path = RouteLocation.splash;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<AuthRoute>(path: AuthRoute.path)
class AuthRoute extends GoRouteData {
  const AuthRoute();

  static const path = RouteLocation.auth;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const path = RouteLocation.home;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<MyPageRoute>(path: MyPageRoute.path)
class MyPageRoute extends GoRouteData {
  const MyPageRoute();

  static const path = RouteLocation.myPage;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyPageScreen();
  }
}

@TypedGoRoute<AddResolutionRoute>(path: AddResolutionRoute.path)
class AddResolutionRoute extends GoRouteData {
  const AddResolutionRoute();

  static const path = RouteLocation.addResolution;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AddResolutionScreen();
  }
}

@TypedGoRoute<SwipeViewRoute>(path: SwipeViewRoute.path)
class SwipeViewRoute extends GoRouteData {
  const SwipeViewRoute();

  static const path = RouteLocation.swipeView;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SwipeView();
  }
}

class GoNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did push route $route : $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did pop route $route : $previousRoute');
  }
}
