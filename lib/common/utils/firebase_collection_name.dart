import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  const FirebaseCollectionName._();

  static const users = 'users';
  static const groups = 'groups';

  static final myResolutions = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/resolutions'
      : 'invalid_address';

  static final friends = FirebaseAuth.instance.currentUser != null
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

  static final userReactionBox = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/received_reactions'
      : 'invalid_address';

  /// 사용자가 속해있는 팀에 대한 collection
  static final userGroups = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/groups'
      : 'invalid_address';

  static final confirmPostImageStorageName = FirebaseAuth
              .instance.currentUser !=
          null
      ? '${FirebaseAuth.instance.currentUser?.uid}/confirm_post/_${DateTime.now().toIso8601String()}'
      : 'invalid_address';

  static String getGroupApplyWaitingCollectionName(String groupId) {
    return '$groups/$groupId/apply_waiting';
  }

  static String getConfirmPostQuickShotReactionStorageName(
    String postOwnerUid,
    String confirmPostId,
  ) {
    return '$postOwnerUid/confirm_post/$confirmPostId/_${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toIso8601String()}';
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
