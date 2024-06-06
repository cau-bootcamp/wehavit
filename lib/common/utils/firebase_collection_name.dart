import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  const FirebaseCollectionName._();

  static const users = 'users';
  static const groups = 'groups';

  static String get myResolutions => FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/resolutions'
      : 'invalid_address';

  static String get friends => FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/friends'
      : 'invalid_address';

  static String getTargetFriendsCollectionName(String fId) {
    final targetFriends = FirebaseAuth.instance.currentUser != null
        ? 'users/$fId/friends'
        : 'invalid_address';
    return targetFriends;
  }

  static String getTargetResolutionCollectionName(String userId) {
    final targetFriends = FirebaseAuth.instance.currentUser != null
        ? 'users/$userId/resolutions'
        : 'invalid_address';
    return targetFriends;
  }

  static String getConfirmPostReactionCollectionName(String confirmPostId) {
    return 'confirm_posts/$confirmPostId/reactions';
  }

  static String getTargetUserReactionBoxCollectionName(String targetUid) {
    return 'users/$targetUid/received_reactions';
  }

  static String get userReactionBox => FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/received_reactions'
      : 'invalid_address';

  /// 사용자가 속해있는 팀에 대한 collection
  static String get userGroups => FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/groups'
      : 'invalid_address';

  static String getTargetUserGroupsCollectionName(String targetUid) {
    return 'users/$targetUid/groups';
  }

  static String get confirmPostImageStorageName => FirebaseAuth
              .instance.currentUser !=
          null
      ? '${FirebaseAuth.instance.currentUser?.uid}/confirm_post/_${DateTime.now().toIso8601String()}'
      : 'invalid_address';

  static String getUserApplyWaitingCollectionName(String userId) {
    return '$users/$userId/apply_waiting';
  }

  static String getGroupApplyWaitingCollectionName(String groupId) {
    return '$groups/$groupId/apply_waiting';
  }

  static String getTargetGroupAnnouncemenetCollectionName(String groupId) {
    return '$groups/$groupId/announcements';
  }

  static final confirmPosts = FirebaseAuth.instance.currentUser != null
      ? 'confirm_posts'
      : 'invalid_address';
  static final encourages = FirebaseAuth.instance.currentUser != null
      ? 'encourages'
      : 'invalid_address';
  static const liveConfirmPosts = 'live_confirm_posts';

  static final liveWaitingUsers = FirebaseAuth.instance.currentUser != null
      ? 'live_waiting_users'
      : 'invalid_address';
}
