import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  const FirebaseCollectionName._();

  static const users = 'users';
  static final myResolutions = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/resolutions'
      : 'invalid_address';
  static final friends = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/friends'
      : 'invalid_address';

  static String getTargetFriendsCollection(String fId) {
    final targetFriends = FirebaseAuth.instance.currentUser != null
        ? 'users/$fId/friends'
        : 'invalid_address';
    return targetFriends;
  }

  static final confirmPosts = FirebaseAuth.instance.currentUser != null
      ? 'confirm_posts'
      : 'invalid_address';
  static final encourages = FirebaseAuth.instance.currentUser != null
      ? 'encourages'
      : 'invalid_address';
  static const liveConfirmPosts = 'live_confirm_posts';
}
