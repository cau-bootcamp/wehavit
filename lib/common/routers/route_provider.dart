import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';

part 'route_provider.g.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateChangesProvider);

    return GoRouter(
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

        if (!isLoggedIn) return RouteLocation.auth;
        if (isLoggedIn) {
          // Redirect to TestScreen if environment is development
          if (Application.environment == Environment.development.toString()) {
            debugPrint('Redirect to TestScreen on development');
            return RouteLocation.testPage;
          }
        }
        return null;
      },
    );
  },
);

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const path = RouteLocation.main;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainView();
  }
}

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  static const path = RouteLocation.splash;

  // @override
  // FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
  //   final authState = ProviderScope.containerOf(context).read(
  //     authStateChangesProvider,
  //   );

  //   final isLoggedIn = authState.when(
  //     data: (value) => value != null,
  //     loading: () => false,
  //     error: (error, stackTrace) => false,
  //   );
  //   final isLoggingIn = state.matchedLocation == RouteLocation.auth;

  //   if (!isLoggedIn && !isLoggingIn) {
  //     return RouteLocation.auth;
  //   }

  //   if (isLoggedIn) {
  //     // Redirect to TestScreen if environment is development
  //     if (Application.environment == Environment.development.toString()) {
  //       debugPrint('Redirects to TestScreen on development');
  //       return RouteLocation.testPage;
  //     }
  //   }
  //   return null;
  // }

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
    return const EntranceView();
  }
}

// @TypedGoRoute<MyPageRoute>(path: MyPageRoute.path)
// class MyPageRoute extends GoRouteData {
//   const MyPageRoute();

//   static const path = RouteLocation.myPage;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const MyPageView();
//   }
// }

// @TypedGoRoute<TestPageRoute>(path: TestPageRoute.path)
// class TestPageRoute extends GoRouteData {
//   const TestPageRoute();

//   static const path = RouteLocation.testPage;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const TestPage();
//   }
// }

@TypedGoRoute<AddResolutionRoute>(path: AddResolutionRoute.path)
class AddResolutionRoute extends GoRouteData {
  const AddResolutionRoute();

  static const path = RouteLocation.addResolution;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AddResolutionScreen();
  }
}

// @TypedGoRoute<FriendListRoute>(path: FriendListRoute.path)
// class FriendListRoute extends GoRouteData {
//   const FriendListRoute();

//   static const path = RouteLocation.friendList;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const FriendListView();
//   }
// }

@TypedGoRoute<AnimationSampleViewRoute>(path: AnimationSampleViewRoute.path)
class AnimationSampleViewRoute extends GoRouteData {
  const AnimationSampleViewRoute();

  static const path = RouteLocation.animationSampleView;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AnimationSamplePage();
  }
}

// @TypedGoRoute<ReactionSampleViewRoute>(path: ReactionSampleViewRoute.path)
// class ReactionSampleViewRoute extends GoRouteData {
//   const ReactionSampleViewRoute();

//   static const path = RouteLocation.reactionSampleView;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const ReactionSampleView();
//   }
// }

// @TypedGoRoute<GroupSampleViewRoute>(path: GroupSampleViewRoute.path)
// class GroupSampleViewRoute extends GoRouteData {
//   const GroupSampleViewRoute();

//   static const path = RouteLocation.groupSampleView;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const SampleGroupWidget();
//   }
// }

// @TypedGoRoute<GroupViewRoute>(path: GroupViewRoute.path)
// class GroupViewRoute extends GoRouteData {
//   const GroupViewRoute();

//   static const path = RouteLocation.groupView;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const GroupView();
//   }
// }

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
