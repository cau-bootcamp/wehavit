import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';
import 'package:wehavit/presentation/home/data/datasources/confirm_post_datasource.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  @override
  EitherFuture<List<ConfirmPostModel>> getAllFanMarkedConfirmPosts() async {
    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.confirmPosts,
          )
          .where(
            FirebaseConfirmPostFieldName.fan,
            arrayContains: FirebaseAuth.instance.currentUser!.email,
          )
          .get();

      debugPrint(fetchResult.docs.length.toString());

      List<ConfirmPostModel> confirmPosts = fetchResult.docs
          .map((doc) => ConfirmPostModel.fromFireStoreDocument(doc))
          .toList();

      return Future(() => right(confirmPosts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getAllFanMarkedConfirmPosts'),
        ),
      );
    }
  }

  @override
  EitherFuture<bool> uploadConfirmPost(ConfirmPostModel confirmPost) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .add(confirmPost.toJson());

    return Future(() => right(true));
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostModel> ref,
  ) {
    // TODO: implement deleteConfirmPost
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> getConfirmPostByUserId(String userId) {
    // TODO: implement getConfirmPostByUserId
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost) {
    FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .doc(confirmPost.id)
        .update(confirmPost.toJson());

    return Future(() => right(true));
  }

  @override
  EitherFuture<ConfirmPostModel> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  ) async {
    DateTime today = DateTime.now();
    DateTime recentPostTime = today.hour >= 22
        ? DateTime(
            today.year,
            today.month,
            today.day,
            22,
          ) // today 10pm
        : DateTime(
            today.year,
            today.month,
            today.day - 1,
            22,
          ); // yesterday 10pm

    // check existing confirm post
    final existingConfirmPost = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .where(
          FirebaseConfirmPostFieldName.owner,
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .where(
          FirebaseConfirmPostFieldName.resolutionId,
          isEqualTo: resolutionId,
        )
        .where(
          FirebaseConfirmPostFieldName.createdAt,
          isGreaterThan: Timestamp.fromDate(recentPostTime),
        )
        .get()
        .then((value) => value.docs.firstOrNull);

    if (existingConfirmPost != null) {
      return Future(
        () =>
            right(ConfirmPostModel.fromFireStoreDocument(existingConfirmPost)),
      );
    } else {
      return Future(() => left(const Failure('no existing post')));
    }
  }

  @override
  EitherFuture<List<ConfirmPostModel>> getConfirmPostEntityList(
      int selectedIndex) {
    // TODO: implement getConfirmPostEntityList
    throw UnimplementedError();
  }
}
