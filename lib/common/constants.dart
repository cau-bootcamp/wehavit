import 'package:flutter_animate/flutter_animate.dart';

class AppKeys {
  const AppKeys._();

  static const String emailScope = 'email';
  static const String kLocale = 'locale';
  static const String kDarkMode = 'darkMode';
  static const String quoteId = 'quoteId';
  static const String id = 'id';
  static const String dbTable = 'quotes';
  static final Duration kAnimationDuration = 1500.ms;
}

const appTitle = 'WeHavit';

enum Environment {
  development,
  production,
}

class Application {
  const Application._();

  static String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.production.toString(),
  );
}
