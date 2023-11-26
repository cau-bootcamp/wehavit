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

//      print('\n'
//          'isGreaterThan: ${Timestamp.fromDate(startDate)}\n'
//          'isLessThan: ${Timestamp.fromDate(endDate)}');
      // 첫 번째 쿼리 결과
      QuerySnapshot firstQueryResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.createdAt,
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          )
          .where(
            FirebaseConfirmPostFieldName.createdAt,
            isLessThan: Timestamp.fromDate(endDate),
          )
          .get();

      // 두 번째 쿼리 결과
      QuerySnapshot secondQueryResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.fan,
            arrayContains: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();

// 첫 번째 쿼리 결과에서 문서 ID 추출
      Set<String> firstQueryDocIds =
          firstQueryResult.docs.map((doc) => doc.id).toSet();

// 두 번째 쿼리 결과에서 문서 ID 추출
      Set<String> secondQueryDocIds =
          secondQueryResult.docs.map((doc) => doc.id).toSet();

// 교집합 찾기
      Set<String> intersection =
          firstQueryDocIds.intersection(secondQueryDocIds);

// 최종 결과: 교집합에 해당하는 문서들
      List<QueryDocumentSnapshot> resultDocs = firstQueryResult.docs
          .where((doc) => intersection.contains(doc.id))
          .toList();

      debugPrint(resultDocs.length.toString());

      final userDocsList = resultDocs
          .map(
            (doc) =>
                (doc.data() as dynamic)[FirebaseConfirmPostFieldName.owner],
          )
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

      List<ConfirmPostEntity> confirmPosts = resultDocs
          .map(
            (doc) => ConfirmPostEntity.fromFirebaseDocument(
              userDataMap[
                  (doc.data() as dynamic)[FirebaseConfirmPostFieldName.owner]]!,
              doc.data() as dynamic,
            ),
          )
          .toList();

      return Future(() => right(confirmPosts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getConfirmPostEntityList'),
        ),
      );
    }
  }
}
