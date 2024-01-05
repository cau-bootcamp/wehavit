import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_model.dart';
import 'package:wehavit/presentation/swipe_view/data/datasource/reaction_datasource.dart';

class ReactionDatasourceImpl implements ReactionDatasource {
  @override
  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionModel reactionModel,
  ) async {
    try {
      if (reactionModel.reactionType == ReactionType.instantPhoto.index) {
        final savePhotoResult = await _saveImageFileToFirebaseStorage(
          filePath: reactionModel.instantPhotoUrl,
          confirmPostid: targetConfirmPostId,
        );
        savePhotoResult.fold(
          (failure) {
            debugPrint(
              'DEBUG : Failure on Saving image file to Firebase Storage - ${failure.message}',
            );
          },
          (filePath) {
            reactionModel = reactionModel.copyWith(instantPhotoUrl: filePath);
          },
        );
      }
      FirebaseFirestore.instance
          .collection(
        '${FirebaseCollectionName.confirmPosts}/$targetConfirmPostId/${FirebaseCollectionName.encourages}',
      )
          .add(
        {
          FirebaseReactionFieldName.complimenterUid:
              FirebaseAuth.instance.currentUser!.uid,
          FirebaseReactionFieldName.reactionType: reactionModel.reactionType,
          FirebaseReactionFieldName.emoji: reactionModel.emoji,
          FirebaseReactionFieldName.instantPhotoUrl:
              reactionModel.instantPhotoUrl,
          FirebaseReactionFieldName.comment: reactionModel.comment,
          FirebaseReactionFieldName.hasRead: false,
        },
      );
      print(targetConfirmPostId);
      return Future(() => right(true));
    } on Exception {
      debugPrint('DEBUG : Error on sendReactionToTargetConfirmPost Function');
      return Future(
        () => left(
          const Failure('Error on sendReactionToTargetConfirmPost Function'),
        ),
      );
    }
  }

  EitherFuture<String> _saveImageFileToFirebaseStorage(
      {required String confirmPostid, required String filePath}) async {
    try {
      String storagePath =
          '$confirmPostid/_${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toIso8601String()}';
      final ref = FirebaseStorage.instance.ref(storagePath);

      await ref.putFile(File(filePath));
      return Future(() async => right(await ref.getDownloadURL()));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<List<ReactionModel>>
      getReactionUnreadFromLastConfirmPost() async {
    final confirmPostFetchResult = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    final temp = confirmPostFetchResult.docs.toList();
    final myLatestConfirmPostId = temp.first.reference.id;

    final encourages = await FirebaseFirestore.instance
        .collection(
          '${FirebaseCollectionName.confirmPosts}/$myLatestConfirmPostId/${FirebaseCollectionName.encourages}',
        )
        .where('hasRead', isEqualTo: false)
        .get();

    // 이 로직으로 응원 데이터는 한 번만 가져올 수 있음
    for (var doc in encourages.docs) {
      FirebaseFirestore.instance.doc(doc.reference.path).set(
        {'hasRead': true},
        SetOptions(merge: true),
      );
    }

    final result = encourages.docs
        .map((doc) => ReactionModel.fromJson(doc.data()))
        .toList();

    return Future(
      () => right(result),
    );
  }
}
