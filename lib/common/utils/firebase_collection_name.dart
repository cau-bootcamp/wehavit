import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  const FirebaseCollectionName._();

  static const users = 'users';
  static final resolutions = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/resolutions'
      : 'invalid_address';
  static final friends = FirebaseAuth.instance.currentUser != null
      ? 'users/${FirebaseAuth.instance.currentUser?.uid}/friends'
      : 'invalid_address';

  static String getOpponentFriendsCollection(String fId) {
    final opponentFriend = FirebaseAuth.instance.currentUser != null
        ? 'users/$fId/friends'
        : 'invalid_address';
    return opponentFriend;
  }

  static final confirmPosts = FirebaseAuth.instance.currentUser != null
      ? 'confirm_posts'
      : 'invalid_address';
  static final encourages = FirebaseAuth.instance.currentUser != null
      ? 'encourages'
      : 'invalid_address';
  static const liveConfirmPosts = 'live_confirm_posts';
}
