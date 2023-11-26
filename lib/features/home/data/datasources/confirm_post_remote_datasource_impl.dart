import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/data/datasources/confirm_post_datasource.dart';
import 'package:wehavit/features/home/data/entities/confirm_post_entity.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  static const int maxDay = 27;

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList(
    int selectedIndex,
  ) async {
    try {
      int nDaysAgo = maxDay - selectedIndex;
      DateTime today = DateTime.now();
      DateTime startDate = DateTime(today.year, today.month, today.day)
          .subtract(Duration(days: nDaysAgo));
      DateTime endDate =
          DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: 1));

      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.fan,
            arrayContains: FirebaseAuth.instance.currentUser!.uid,
          )
          .where(
            FirebaseConfirmPostFieldName.updatedAt,
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
            isLessThan: Timestamp.fromDate(endDate),
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
