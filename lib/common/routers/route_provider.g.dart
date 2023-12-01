// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $splashRoute,
      $authRoute,
      $myPageRoute,
      $testPageRoute,
      $addResolutionRoute,
      $friendListRoute,
      $liveWritingRoute,
      $swipeViewRoute,
      $animationSampleViewRoute,
      $liveWaitingSampleViewRoute,
      $lateWritingViewRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthRouteExtension._fromState,
    );

extension $AuthRouteExtension on AuthRoute {
  static AuthRoute _fromState(GoRouterState state) => const AuthRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myPageRoute => GoRouteData.$route(
      path: '/myPage',
      factory: $MyPageRouteExtension._fromState,
    );

extension $MyPageRouteExtension on MyPageRoute {
  static MyPageRoute _fromState(GoRouterState state) => const MyPageRoute();

  String get location => GoRouteData.$location(
        '/myPage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $testPageRoute => GoRouteData.$route(
      path: '/testPage',
      factory: $TestPageRouteExtension._fromState,
    );

extension $TestPageRouteExtension on TestPageRoute {
  static TestPageRoute _fromState(GoRouterState state) => const TestPageRoute();

  String get location => GoRouteData.$location(
        '/testPage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addResolutionRoute => GoRouteData.$route(
      path: '/addResolution',
      factory: $AddResolutionRouteExtension._fromState,
    );

extension $AddResolutionRouteExtension on AddResolutionRoute {
  static AddResolutionRoute _fromState(GoRouterState state) =>
      const AddResolutionRoute();

  String get location => GoRouteData.$location(
        '/addResolution',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $friendListRoute => GoRouteData.$route(
      path: '/friendList',
      factory: $FriendListRouteExtension._fromState,
    );

extension $FriendListRouteExtension on FriendListRoute {
  static FriendListRoute _fromState(GoRouterState state) =>
      const FriendListRoute();

  String get location => GoRouteData.$location(
        '/friendList',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $liveWritingRoute => GoRouteData.$route(
      path: '/liveWriting',
      factory: $LiveWritingRouteExtension._fromState,
    );

extension $LiveWritingRouteExtension on LiveWritingRoute {
  static LiveWritingRoute _fromState(GoRouterState state) =>
      const LiveWritingRoute();

  String get location => GoRouteData.$location(
        '/liveWriting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $swipeViewRoute => GoRouteData.$route(
      path: '/swipeView',
      factory: $SwipeViewRouteExtension._fromState,
    );

extension $SwipeViewRouteExtension on SwipeViewRoute {
  static SwipeViewRoute _fromState(GoRouterState state) =>
      const SwipeViewRoute();

  String get location => GoRouteData.$location(
        '/swipeView',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $animationSampleViewRoute => GoRouteData.$route(
      path: '/animationSampleView',
      factory: $AnimationSampleViewRouteExtension._fromState,
    );

extension $AnimationSampleViewRouteExtension on AnimationSampleViewRoute {
  static AnimationSampleViewRoute _fromState(GoRouterState state) =>
      const AnimationSampleViewRoute();

  String get location => GoRouteData.$location(
        '/animationSampleView',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $liveWaitingSampleViewRoute => GoRouteData.$route(
      path: '/liveWaitingSampleView',
      factory: $LiveWaitingSampleViewRouteExtension._fromState,
    );

extension $LiveWaitingSampleViewRouteExtension on LiveWaitingSampleViewRoute {
  static LiveWaitingSampleViewRoute _fromState(GoRouterState state) =>
      const LiveWaitingSampleViewRoute();

  String get location => GoRouteData.$location(
        '/liveWaitingSampleView',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $lateWritingViewRoute => GoRouteData.$route(
      path: '/lateWritingView',
      factory: $LateWritingViewRouteExtension._fromState,
    );

extension $LateWritingViewRouteExtension on LateWritingViewRoute {
  static LateWritingViewRoute _fromState(GoRouterState state) =>
      const LateWritingViewRoute();

  String get location => GoRouteData.$location(
        '/lateWritingView',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
