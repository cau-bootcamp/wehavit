// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $splashRoute,
      $authRoute,
      $addResolutionRoute,
      $animationSampleViewRoute,
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

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

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

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

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

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addResolutionRoute => GoRouteData.$route(
      path: '/addResolution',
      factory: $AddResolutionRouteExtension._fromState,
    );

extension $AddResolutionRouteExtension on AddResolutionRoute {
  static AddResolutionRoute _fromState(GoRouterState state) => const AddResolutionRoute();

  String get location => GoRouteData.$location(
        '/addResolution',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $animationSampleViewRoute => GoRouteData.$route(
      path: '/animationSampleView',
      factory: $AnimationSampleViewRouteExtension._fromState,
    );

extension $AnimationSampleViewRouteExtension on AnimationSampleViewRoute {
  static AnimationSampleViewRoute _fromState(GoRouterState state) => const AnimationSampleViewRoute();

  String get location => GoRouteData.$location(
        '/animationSampleView',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
