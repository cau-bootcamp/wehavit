import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_mine_repository.dart';

const livePostDocumentPrefix = 'LIVE-';

class LiveWritingPostRepositoryImpl extends MyLiveWritingRepository {
  LiveWritingPostRepositoryImpl();

  @override
  Future<void> updateMessage(
    String message,
  ) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc(
          '$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.email}',
        )
        .set(
          {
            FirebaseLiveConfirmPostFieldName.userId:
                FirebaseAuth.instance.currentUser!.uid,
            FirebaseLiveConfirmPostFieldName.message: message,
          },
          SetOptions(merge: true),
        )
        .then((value) =>
            debugPrint('New live confirm document with message created'))
        .catchError((error) => debugPrint('Failed to add document: $error'));
  }

  @override
  Future<void> updateTitle(
    String title,
  ) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc(
          '$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.email}',
        )
        .set(
          {
            FirebaseLiveConfirmPostFieldName.userId:
                FirebaseAuth.instance.currentUser!.uid,
            FirebaseLiveConfirmPostFieldName.title: title,
          },
          SetOptions(merge: true),
        )
        .then((value) =>
            debugPrint('New live confirm document with title created'))
        .catchError((error) => debugPrint('Failed to add document: $error'));
  }
}
