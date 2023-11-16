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
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

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
          FirebaseReactionFieldName.complementerUid:
              '/users/${FirebaseAuth.instance.currentUser!.uid}',
          FirebaseReactionFieldName.reactionType: reactionModel.reactionType,
          FirebaseReactionFieldName.emoji: reactionModel.emoji,
          FirebaseReactionFieldName.instantPhotoUrl:
              reactionModel.instantPhotoUrl,
          FirebaseReactionFieldName.comment: reactionModel.comment,
          FirebaseReactionFieldName.hasRead: false,
        },
      );

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
      await FirebaseStorage.instance.ref(storagePath).putFile(File(filePath));
      return Future(() => right(storagePath));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<List<ReactionModel>>
      getReactionNotReadFromLastConfirmPost() async {
    // TODO: 오늘 내 ConfirmPost의 ID를 찾아오는 로직을 간단하게 추가할 필요 있음!!
    final confirmPostFetchResult = await FirebaseFirestore.instance
        .collection('${FirebaseCollectionName.confirmPosts}')
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .orderBy('createdAt', descending: true)
        // .limit(1)
        .get();

    // final myLastConfirmPostId = confirmPostFetchResult.docs.first.reference.id;

    final temp = confirmPostFetchResult.docs.toList();

    final myLatestConfirmPostId = temp.first.reference.id;
    // final myLastConfirmPostId = temp
    //     .reduce((value, element) =>
    //         value.data()['createdAt'] < element.data()['createdAt']
    //             ? value
    //             : element)
    //     .reference
    //     .id;
    //       (value, doc) => ((value.data()['createdAt'] < doc.data()['createdAt']
    //           ? value
    //           : doc)),
    //     )
    //     .reference
    //     .id;

    final encourages = await FirebaseFirestore.instance
        .collection(
          '${FirebaseCollectionName.confirmPosts}/$myLatestConfirmPostId/${FirebaseCollectionName.encourages}',
        )
        .where('hasRead', isEqualTo: false)
        .get();

    final result = encourages.docs
        .map((doc) => ReactionModel.fromJson(doc.data()))
        .toList();

    return Future(
      () => right(result),
    );
  }
}
