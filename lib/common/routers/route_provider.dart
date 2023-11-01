import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/features.dart';
import 'package:wehavit/features/live_writing/presentation/screens/live_writing_page.dart';
import 'package:wehavit/features/my_page/presentation/screens/add_resolution_screen.dart';
import 'package:wehavit/features/my_page/presentation/screens/my_page_screen.dart';

part 'route_provider.g.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateChangesProvider);

    return GoRouter(
      initialLocation: RouteLocation.splash,
      navigatorKey: navigationKey,
      debugLogDiagnostics: true,
      routes: $appRoutes,
      errorBuilder: (context, state) => const ErrorScreen(),
      redirect: (context, state) async {
        final isLoggedIn = authState.when(
          data: (value) => value != null,
          loading: () => false,
          error: (error, stackTrace) => false,
        );
        final isLoggingIn = state.matchedLocation == RouteLocation.auth;

        if (!isLoggedIn && !isLoggingIn) return RouteLocation.auth;
        if (isLoggedIn && isLoggingIn) {
          // Redirect to TestScreen if environment is development
          if (Application.environment == Environment.development.toString()) {
            debugPrint('Redirect to TestScreen on development');
            return RouteLocation.testPage;
          }
          return RouteLocation.myPage;
        }
        return null;
      },
    );
  },
);

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  static const path = RouteLocation.splash;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final authState = ProviderScope.containerOf(context).read(
      authStateChangesProvider,
    );

    final isLoggedIn = authState.when(
      data: (value) => value != null,
      loading: () => false,
      error: (error, stackTrace) => false,
    );
    final isLoggingIn = state.matchedLocation == RouteLocation.auth;
    if (!isLoggedIn && !isLoggingIn) {
      return RouteLocation.auth;
    }

    if (isLoggedIn) {
      // Redirect to TestScreen if environment is development
      if (Application.environment == Environment.development.toString()) {
        debugPrint('Redirects to TestScreen on development');
        return RouteLocation.testPage;
      }

      return RouteLocation.myPage;
    }
    return null;
  }

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

@TypedGoRoute<TestPageRoute>(path: TestPageRoute.path)
class TestPageRoute extends GoRouteData {
  const TestPageRoute();

  static const path = RouteLocation.testPage;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TestPage();
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

@TypedGoRoute<LiveWritingRoute>(path: LiveWritingRoute.path)
class LiveWritingRoute extends GoRouteData {
  const LiveWritingRoute();

  static const path = RouteLocation.liveWriting;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LiveWritingPage();
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
