import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/data/datasources/confirm_post_datasource.dart';
import 'package:wehavit/features/home/data/entities/confirm_post_entity.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  static const CONFIRM_POST_COLLECTION = 'confirm_posts';
  static const CONFIRM_POST_FIELD_FAN = 'fan';
  static const CONFIRM_POST_FIELD_OWNER = 'owner';

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList(
    int selectedIndex,
  ) async {
    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(CONFIRM_POST_COLLECTION)
          .where(
            CONFIRM_POST_FIELD_FAN,
            arrayContains: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();

      final userDocsList = fetchResult.docs
          .map((doc) => doc.data()[FirebaseConfirmPostFieldName.owner])
          .toList();

      Map<String, (String, String)> userDataMap = {};
      for (var userDoc in userDocsList) {
        if (userDataMap[userDoc] == null) {
          final fetchUserResult = await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.users)
              .doc(userDoc)
              .get();
          userDataMap[userDoc] = (
            fetchUserResult.data()?[FirebaseUserFieldName.imageUrl],
            fetchUserResult.data()?[FirebaseUserFieldName.displayName]
          );
        }
      }

      debugPrint(fetchResult.docs.length.toString());

      List<ConfirmPostEntity> confirmPosts = fetchResult.docs
          .map(
            (doc) => ConfirmPostEntity.fromFirebaseDocument(
              userDataMap[doc.data()[FirebaseConfirmPostFieldName.owner]]!,
              doc.data(),
            ),
          )
          .toList();

      return Future(() => right(confirmPosts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveResolutionEntityList'),
        ),
      );
    }
  }
}
