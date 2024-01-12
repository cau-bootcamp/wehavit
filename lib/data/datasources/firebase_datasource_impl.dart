import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/data/models/user_model.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';

class FirebaseDatasourceImpl implements WehavitDatasource {
  int get maxDay => 27;

  @override
  EitherFuture<List<UserModel>> getFriendModelList() async {
    // users에서 내 user 정보 접근해서 friends 리스트 받아오기
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final friendDocument =
          await firestore.collection(FirebaseCollectionName.friends).get();

      List<UserModel?> fetchResult = await Future.wait(
        friendDocument.docs.map((doc) async {
          return getUserModelByUserId(
            doc.data()[FirebaseFriendFieldName.friendUid],
          );
        }),
      );

      return Future(() => right(fetchResult.whereNotNull().toList()));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on registerFriend'),
        ),
      );
    }
  }

  @override
  EitherFuture<bool> registerFriend(String email) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final friendDocument = await firestore
          .collection(FirebaseCollectionName.users)
          .where(FirebaseUserFieldName.email, isEqualTo: email)
          .get();

      if (friendDocument.size == 0) {
        return Future(
          () => left(
            const Failure('friend email does not exist'),
          ),
        );
      }

      final friendUid = friendDocument.docs.first.id;

      final isFriendAlreadyRegistered = await checkIsAlreadyFriend(friendUid);

      if (!isFriendAlreadyRegistered) {
        await firestore.collection(FirebaseCollectionName.friends).add(
          {
            FirebaseFriendFieldName.friendUid: friendUid,
            FirebaseFriendFieldName.friendState: '0',
          },
        );

        return Future(
          () => right(true),
        );
      } else {
        return Future(
          () => left(
            const Failure('already registered friend'),
          ),
        );
      }
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on registerFriend'),
        ),
      );
    }
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList(
    int selectedDate,
  ) async {
    try {
      int nDaysAgo = maxDay - selectedDate;
      DateTime today = DateTime.now();
      DateTime startDate = DateTime(today.year, today.month, today.day)
          .subtract(Duration(days: nDaysAgo));
      DateTime endDate =
          DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: 1));

//      print('\n'
//          'isGreaterThan: ${Timestamp.fromDate(startDate)}\n'
//          'isLessThan: ${Timestamp.fromDate(endDate)}');
      // 1. 결과 start 2 end date confirmpost
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

      // 두 번째 쿼리 결과: Fan
      QuerySnapshot secondQueryResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.fan,
            arrayContains: FirebaseAuth.instance.currentUser!.email,
          )
          .get();

      // 세 번째 쿼리 결과
      var thirdQueryResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.owner,
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();

// 첫 번째 쿼리 결과에서 문서 ID 추출
      Set<String> firstQueryDocIds =
          firstQueryResult.docs.map((doc) => doc.id).toSet();

// 두 번째 쿼리 결과에서 문서 ID 추출
      Set<String> secondQueryDocIds =
          secondQueryResult.docs.map((doc) => doc.id).toSet();

// 세 번째 쿼리 결과에서 문서 ID 추출
      Set<String> thirdQueryDocIds =
          thirdQueryResult.docs.map((doc) => doc.id).toSet();

// 첫 번째와 두 번째 교집합 찾기 : 내 친구의 해당 날짜 게시글
      Set<String> firstIntersection =
          firstQueryDocIds.intersection(secondQueryDocIds);

      // 첫 번째와 세 번째 교집합 찾기 : 내 해당 날짜 게시글
      Set<String> secondIntersection =
          firstQueryDocIds.intersection(thirdQueryDocIds);

// 최종 결과: 교집합에 해당하는 문서들
      List<QueryDocumentSnapshot> resultDocs = firstQueryResult.docs
          .where((doc) => firstIntersection.contains(doc.id))
          .toList();

      resultDocs.addAll(
        firstQueryResult.docs
            .where((doc) => secondIntersection.contains(doc.id))
            .toList(),
      );

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

      // TODO: 아래 코드 구현하기
      List<ConfirmPostEntity> confirmPosts = List.empty();

      // List<ConfirmPostEntity> confirmPosts = resultDocs
      //     .map(
      //       (doc) => FirebaseConfirmPostModel.fromJson(
      //         userDataMap[
      //             (doc.data() as dynamic)[FirebaseConfirmPostFieldName.owner]],
      //       ).toConfirmPostEntity(),
      //     )
      //     .toList();

      return Future(() => right(confirmPosts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getConfirmPostEntityList'),
        ),
      );
    }
  }

  // TODO: 여기에 Datasource 에서 팔요한 함수 구현 추가하기
  // Confirm Post Repository

  @override
  EitherFuture<ConfirmPostEntity> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  ) {
    return Future(() => left(const Failure('not implemented')));
  }

  @override
  EitherFuture<bool> uploadConfirmPost(ConfirmPostEntity confirmPost) {
    return Future(() => left(const Failure('not implemented')));
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost) {
    return Future(() => left(const Failure('not implemented')));
  }

  @override
  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionEntity,
  ) {
    return Future(() => left(const Failure('not implemented')));
  }

  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList() {
    return Future(() => left(const Failure('not implemented')));
  }

  @override
  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity) {
    return Future(() => left(const Failure('not implemented')));
  }

  @override
  EitherFuture<UserModel> fetchUserModelFromId(String targetUserId) {
    return Future(() => left(const Failure('not implemented')));
  }

  Future<UserModel?> getUserModelByUserId(String targetUserId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final friendDocument = await firestore
          .collection(FirebaseCollectionName.users)
          .doc(targetUserId)
          .get();

      final result = UserModel(
        uid: targetUserId,
        displayName: friendDocument.data()![FirebaseUserFieldName.displayName],
        imageUrl: friendDocument.data()![FirebaseUserFieldName.imageUrl],
        email: friendDocument.data()![FirebaseUserFieldName.email],
      );

      return result;
    } on Exception {
      return null;
    }
  }

  Future<bool> checkIsAlreadyFriend(String friendUid) async {
    final result = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.friends)
        .where(FirebaseFriendFieldName.friendUid, isEqualTo: friendUid)
        .get()
        .then((value) => value.size)
        .then(
          (value) => value >= 1 ? true : false,
        );

    return result;
  }
}
