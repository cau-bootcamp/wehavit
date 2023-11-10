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
        '${FirebaseCollectionName.confirmPost}/$targetConfirmPostId/encourages',
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
          '$confirmPostid/${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toIso8601String()}';
      await FirebaseStorage.instance.ref(storagePath).putFile(File(filePath));
      return Future(() => right(storagePath));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
