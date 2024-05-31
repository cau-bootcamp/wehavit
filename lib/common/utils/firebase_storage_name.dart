import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class FirebaseStorageName {
  const FirebaseStorageName._();

  static String getConfirmPostQuickShotReactionStorageName(
    String postOwnerUid,
    String confirmPostId,
  ) {
    return '$postOwnerUid/confirm_post/$confirmPostId/_${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toIso8601String()}';
  }

  static String getUserProfilePhotoStorageName(String userId) {
    return '$userId/profile_photo/_${DateTime.now().toIso8601String()}';
  }
}
