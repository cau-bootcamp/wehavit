// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $authRoute,
      $homeRoute,
      $myPageRoute,
      $testPageRoute,
      $addResolutionRoute,
      $friendListRoute,
      $liveWritingRoute,
    ];

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
      path: '/waitingRoom/liveWriting',
      factory: $LiveWritingRouteExtension._fromState,
    );

extension $LiveWritingRouteExtension on LiveWritingRoute {
  static LiveWritingRoute _fromState(GoRouterState state) =>
      const LiveWritingRoute();

  String get location => GoRouteData.$location(
        '/waitingRoom/liveWriting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
