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
  static const resolutionFanList = 'fan';
}

@immutable
class FirebaseReactionFieldName {
  static const complimenterUid = 'complimenterUid';
  static const comment = 'comment';
  static const emoji = 'emoji';
  static const hasRead = 'hasRead';
  static const instantPhotoUrl = 'instantPhotoUrl';
  static const reactionType = 'reactionType';
}

@immutable
class FirebaseFriendFieldName {
  //friend
  static const friendName = 'friendName';
  static const friendImageUrl = 'friendImageUrl';
  static const friendEmail = 'friendEmail';
  static const friendState = 'friendState';
}

@immutable
class FirebaseLiveConfirmPostFieldName {
  static const title = 'title';
  static const message = 'message';
  static const userId = 'userId';
  static const imageUrl = 'imageUrl';
}

@immutable
class FirebaseConfirmPostFieldName {
  static const content = 'content';
  static const createdAt = 'createdAt';
  static const fan = 'fan';
  static const imageUrl = 'imageUrl';
  static const owner = 'owner';
  static const recentStrike = 'recentStrike';
  static const resolutionGoalStatement = 'resolutionGoalStatement';
  static const resolutionId = 'resolutionId';
  static const title = 'title';
  static const updatedAt = 'updatedAt';
}

@immutable
class FirebaseLiveWaitingFieldName {
  static const String updatedAt = 'updatedAt';
  static const String userId = 'userId';
  static const String email = 'email';
  static const String imageUrl = 'imageUrl';
}
