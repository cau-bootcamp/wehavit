import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_confirm_post_repository_provider.g.dart';

const livePostDocumentPrefix = 'LIVE-';

class LiveConfirmPostRepository {
  LiveConfirmPostRepository();

  // update message on live_confirm_posts
  Future<void> updateMessage(
    String message,
  ) async {
    await FirebaseFirestore.instance
        .collection('live_confirm_posts')
        .doc('$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.uid}')
        .set(
          {
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'message': message,
          },
          SetOptions(merge: true),
        )
        .then((value) =>
            debugPrint('New live confirm document with message created'))
        .catchError((error) => debugPrint('Failed to add document: $error'));
  }

  Future<void> updateTitle(
    String title,
  ) async {
    await FirebaseFirestore.instance
        .collection('live_confirm_posts')
        .doc('$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.uid}')
        .set(
          {
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'title': title,
          },
          SetOptions(merge: true),
        )
        .then((value) =>
            debugPrint('New live confirm document with title created'))
        .catchError((error) => debugPrint('Failed to add document: $error'));
  }
}

@riverpod
LiveConfirmPostRepository liveConfirmPostRepository(
  LiveConfirmPostRepositoryRef ref,
) =>
    LiveConfirmPostRepository();
