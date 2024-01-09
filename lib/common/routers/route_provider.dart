import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/legacy/live_writing/presentation/screens/live_writing_view.dart';
import 'package:wehavit/legacy/live_writing_waiting/live_waiting_sample_view.dart';
import 'package:wehavit/presentation/effects/animation_sample_page.dart';
import 'package:wehavit/presentation/features.dart';
import 'package:wehavit/legacy/swipe_view/presentation/screen/swipe_view.dart';
import 'package:wehavit/presentation/home/screens/home_screen.dart';
import 'package:wehavit/presentation/late_writing/screen/late_writing_view.dart';
import 'package:wehavit/presentation/my_page/screens/add_resolution_screen.dart';
import 'package:wehavit/presentation/my_page/screens/my_page_screen.dart';

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

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const path = RouteLocation.home;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

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

@TypedGoRoute<FriendListRoute>(path: FriendListRoute.path)
class FriendListRoute extends GoRouteData {
  const FriendListRoute();

  static const path = RouteLocation.friendList;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FriendListScreen();
  }
}

@TypedGoRoute<LiveWritingRoute>(path: LiveWritingRoute.path)
class LiveWritingRoute extends GoRouteData {
  const LiveWritingRoute();

  static const path = RouteLocation.liveWriting;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LiveWritingView();
  }
}

@TypedGoRoute<SwipeViewRoute>(path: SwipeViewRoute.path)
class SwipeViewRoute extends GoRouteData {
  const SwipeViewRoute();

  static const path = RouteLocation.swipeView;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SwipeView();
  }
}

@TypedGoRoute<AnimationSampleViewRoute>(path: AnimationSampleViewRoute.path)
class AnimationSampleViewRoute extends GoRouteData {
  const AnimationSampleViewRoute();

  static const path = RouteLocation.animationSampleView;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AnimationSamplePage();
  }
}

@TypedGoRoute<LiveWaitingSampleViewRoute>(path: LiveWaitingSampleViewRoute.path)
class LiveWaitingSampleViewRoute extends GoRouteData {
  const LiveWaitingSampleViewRoute();

  static const path = RouteLocation.liveWaitingSampleView;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LiveWaitingSampleView();
  }
}

@TypedGoRoute<LateWritingViewRoute>(path: LateWritingViewRoute.path)
class LateWritingViewRoute extends GoRouteData {
  const LateWritingViewRoute();

  static const path = RouteLocation.lateWritingView;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LateWritingView();
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
