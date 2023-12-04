import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

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
    ).catchError((error) => debugPrint('Failed to add document: $error'));
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
    ).catchError((error) => debugPrint('Failed to add document: $error'));
  }

  @override
  Future<String> updatePostImage(String imageFileUrl) async {
    try {
      String storagePath =
          'live/_${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toIso8601String()}';
      final ref = FirebaseStorage.instance.ref(storagePath);
      await ref.putFile(File(imageFileUrl));
      final storageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.liveConfirmPosts)
          .doc(
            '$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.email}',
          )
          .set(
        {
          FirebaseLiveConfirmPostFieldName.userId:
              FirebaseAuth.instance.currentUser!.uid,
          FirebaseLiveConfirmPostFieldName.imageUrl: storageUrl,
        },
        SetOptions(merge: true),
      ).catchError((error) => debugPrint('Failed to add document: $error'));

      return Future(() => storageUrl);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  @override
  Stream<List<ReactionModel>> getReactionListStream() {
    final stream = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc(
          '$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.email}',
        )
        .collection(FirebaseCollectionName.encourages)
        .snapshots()
        .map((event) => event.docs)
        .map(
          (docs) => docs
              .map(
                (doc) => ReactionModel.fromFireStoreDocument(doc),
              )
              .toList(),
        );

    return stream;
  }

  @override
  Future<bool> consumeReaction(String reactionId) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc(
          '$livePostDocumentPrefix${FirebaseAuth.instance.currentUser!.email}',
        )
        .collection(FirebaseCollectionName.encourages)
        .doc(reactionId)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
