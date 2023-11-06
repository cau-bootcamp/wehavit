import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseUserFieldName {
  const FirebaseUserFieldName._();

  //users
  static const displayName = 'displayName';
  static const email = 'email';
  static const imageUrl = 'imageUrl';
}

@immutable
class FirebaseResolutionFieldName {
  // resolutions
  static const resolutionGoalStatement = 'goalStatement';
  static const resolutionActionStatement = 'actionStatement';
  static const resolutionOathStatement = 'oathStatement';
  static const resolutionStartDate = 'startDate';
  static const resolutionPeriod = 'period';
  static const resolutionIsActive = 'isActive';
}
