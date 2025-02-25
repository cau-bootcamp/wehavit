import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseUserFieldName {
  const FirebaseUserFieldName._();
  //users
  static const displayName = 'displayName';
  static const handle = 'handle';
  static const imageUrl = 'imageUrl';
  static const createdAt = 'createdAt';
  static const cumulativeGoals = 'cumulativeGoals';
  static const cumulativePosts = 'cumulativePosts';
  static const cumulativeReactions = 'cumulativeReactions';
  static const aboutMe = 'aboutMe';
  static const applyUid = 'uid';
  static const friendUid = 'userId';
  static const messageToken = 'messageToken';
}

@immutable
class FirebaseResolutionFieldName {
  // resolutions
  static const resolutionGoalStatement = 'goalStatement';
  static const resolutionActionStatement = 'actionStatement';
  static const resolutionStartDate = 'startDate';
  static const resolutionActionPerWeek = 'actionPerWeek';
  static const resolutionIsActive = 'isActive';
  static const resolutionShareFriendIdList = 'shareFriendIdList';
  static const resolutionShareGroupIdList = 'shareGroupIdList';
  static const resolutionWrittenPostCount = 'writtenPostCount';
  static const resolutionReceivedReactionCount = 'receivedReactionCount';
  static const resolutionWeekSuccessList = 'successWeekMondayList';
  static const resolutionWeeklyPostcountList = 'weeklyPostCountList';
}

@immutable
class FirebaseReactionFieldName {
  static const complimenterUid = 'complimenterUid';
  static const comment = 'comment';
  static const emoji = 'emoji';
  static const quickShotUrl = 'quickShotUrl';
  static const reactionType = 'reactionType';
}

// @immutable
// class FirebaseFriendFieldName {
//   //friend
//   static const friendUid = 'userId';
//   static const friendState = 'friendState';
// }

@immutable
class FirebaseConfirmPostFieldName {
  static const content = 'content';
  static const createdAt = 'createdAt';
  static const imageUrl = 'imageUrl';
  static const owner = 'owner';
  static const recentStrike = 'recentStrike';
  static const resolutionGoalStatement = 'resolutionGoalStatement';
  static const resolutionId = 'resolutionId';
  static const title = 'title';
  static const updatedAt = 'updatedAt';
  static const attributes = 'attributes';
  static const attributesHasRested = 'has_rested';
}

@immutable
class FirebaseConfirmPostImagePathName {
  static String storagePath({
    required String uid,
  }) {
    return '$uid/confirm_post/$uid/_${DateTime.now().toIso8601String()}';
  }
}

@immutable
class FirebaseGroupFieldName {
  static const String name = 'groupName';
  static const String description = 'groupDescription';
  static const String rule = 'groupRule';
  static const String memberUidList = 'groupMemberUidList';
  static const String managerUid = 'groupManagerUid';
  static const String color = 'groupColor';
  static const String createdAt = 'groupCreatedAt';
  static const String applyUid = 'uid';
}

class FirebaseGroupAnnouncementFieldName {
  static const String content = 'content';
  static const String createdAt = 'createdAt';
  static const String groupId = 'groupId';
  static const String readByUidList = 'readByUidList';
  static const String title = 'title';
  static const String writerUid = 'writerUid';
}

class FirebaseQuickshotPresetItemFieldName {
  static const String url = 'url';
  static const String createdAt = 'createdAt';
}
