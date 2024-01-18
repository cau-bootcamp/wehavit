import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/data/models/firebase_confirm_post_model.dart';
import 'package:wehavit/data/models/firebase_reaction_model.dart';
import 'package:wehavit/data/models/firebase_resolution_model.dart';
import 'package:wehavit/data/models/firebase_user_model.dart';
import 'package:wehavit/data/models/user_model.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

class FirebaseDatasourceImpl implements WehavitDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate(
    DateTime selectedDate,
  ) async {
    try {
      DateTime startDate =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      DateTime endDate =
          DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: 1));

//      print('\n'
//          'isGreaterThan: ${Timestamp.fromDate(startDate)}\n'
//          'isLessThan: ${Timestamp.fromDate(endDate)}');
      // 1. 결과 start 2 end date confirmpost
      final firstQueryResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          // .where(
          //   FirebaseConfirmPostFieldName.createdAt,
          //   isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          // )
          // .where(
          //   FirebaseConfirmPostFieldName.createdAt,
          //   isLessThan: Timestamp.fromDate(endDate),
          // )
          .get();

      // TODO: 아래 코드 구현하기

      // 두 번째 쿼리 결과: Fan
//       QuerySnapshot secondQueryResult = await FirebaseFirestore.instance
//           .collection(FirebaseCollectionName.confirmPosts)
//           .where(
//             FirebaseConfirmPostFieldName.fan,
//             arrayContains: FirebaseAuth.instance.currentUser!.uid,
//           )
//           .get();

//       // 세 번째 쿼리 결과
//       var thirdQueryResult = await FirebaseFirestore.instance
//           .collection(FirebaseCollectionName.confirmPosts)
//           .where(
//             FirebaseConfirmPostFieldName.owner,
//             isEqualTo: FirebaseAuth.instance.currentUser!.uid,
//           )
//           .get();

// // 첫 번째 쿼리 결과에서 문서 ID 추출
//       Set<String> firstQueryDocIds =
//           firstQueryResult.docs.map((doc) => doc.id).toSet();

// // 두 번째 쿼리 결과에서 문서 ID 추출
//       Set<String> secondQueryDocIds =
//           secondQueryResult.docs.map((doc) => doc.id).toSet();

// // 세 번째 쿼리 결과에서 문서 ID 추출
//       Set<String> thirdQueryDocIds =
//           thirdQueryResult.docs.map((doc) => doc.id).toSet();

// // 첫 번째와 두 번째 교집합 찾기 : 내 친구의 해당 날짜 게시글
//       Set<String> firstIntersection =
//           firstQueryDocIds.intersection(secondQueryDocIds);

//       // 첫 번째와 세 번째 교집합 찾기 : 내 해당 날짜 게시글
//       Set<String> secondIntersection =
//           firstQueryDocIds.intersection(thirdQueryDocIds);

// // 최종 결과: 교집합에 해당하는 문서들
//       List<QueryDocumentSnapshot> resultDocs = firstQueryResult.docs
//           .where((doc) => firstIntersection.contains(doc.id))
//           .toList();

//       resultDocs.addAll(
//         firstQueryResult.docs
//             .where((doc) => secondIntersection.contains(doc.id))
//             .toList(),
//       );

//       debugPrint(resultDocs.length.toString());

      // final userDocsList = resultDocs
      //     .map(
      //       (doc) =>
      //           (doc.data() as dynamic)[FirebaseConfirmPostFieldName.owner],
      //     )
      //     .toList();

      // Map<String, (String, String)> userDataMap = {};
      // for (var userDoc in userDocsList) {
      //   if (userDataMap[userDoc] == null) {
      //     final fetchUserResult = await FirebaseFirestore.instance
      //         .collection(FirebaseCollectionName.users)
      //         .doc(userDoc)
      //         .get();
      //     userDataMap[userDoc] = (
      //       fetchUserResult.data()?[FirebaseUserFieldName.imageUrl],
      //       fetchUserResult.data()?[FirebaseUserFieldName.displayName]
      //     );
      //   }
      // }

      // List<ConfirmPostEntity> confirmPosts = List.empty();

      // List<ConfirmPostEntity> confirmPosts = resultDocs.map((doc) {
      //   if (userDataMap doc.data()[FirebaseConfirmPostFieldName.owner])

      //   return FirebaseConfirmPostModel.fromJson(userDataMap[
      //           (doc.data() as dynamic)[FirebaseConfirmPostFieldName.owner]])
      //       .toConfirmPostEntity();
      // }).toList();

      List<ConfirmPostEntity> confirmPosts = await Future.wait(
        firstQueryResult.docs.map(
          (doc) async {
            final model = FirebaseConfirmPostModel.fromFireStoreDocument(doc);
            final fanList = await Future.wait(
              model.fan!
                  .map(
                    (userId) async => (await getUserModelByUserId(userId))!
                        .toUserDataEntity(),
                  )
                  .toList(),
            );
            final ownerUserEntity =
                (await getUserModelByUserId(model.owner!))!.toUserDataEntity();
            final entity = model.toConfirmPostEntity(
              doc.reference.id,
              fanList,
              ownerUserEntity,
            );

            return entity;
          },
        ).toList(),
      );

      return Future(() => right(confirmPosts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getConfirmPostEntityList'),
        ),
      );
    }
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
    String resolutionId,
  ) async {
    try {
      final fetchResult = await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.resolutionId,
            isEqualTo: resolutionId,
          )
          .get();

      List<ConfirmPostEntity> confirmPosts = await Future.wait(
        fetchResult.docs.map(
          (doc) async {
            final model = FirebaseConfirmPostModel.fromFireStoreDocument(doc);
            final fanList = await Future.wait(
              model.fan!
                  .map(
                    (userId) async => (await getUserModelByUserId(userId))!
                        .toUserDataEntity(),
                  )
                  .toList(),
            );
            final ownerUserEntity =
                (await getUserModelByUserId(model.owner!))!.toUserDataEntity();
            final entity = model.toConfirmPostEntity(
              doc.reference.id,
              fanList,
              ownerUserEntity,
            );

            return entity;
          },
        ).toList(),
      );

      return Future(() => right(confirmPosts));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<ConfirmPostEntity> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  ) async {
    try {
      final fetchResult = await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.resolutionId,
            isEqualTo: resolutionId,
          )
          .get();

      if (fetchResult.docs.isEmpty) {
        return Future(
          () => left(Failure('no post today for resolution $resolutionId')),
        );
      } else {
        final model = FirebaseConfirmPostModel.fromFireStoreDocument(
          fetchResult.docs.first,
        );

        final fanList = await Future.wait(
          model.fan!
              .map(
                (userId) async =>
                    (await getUserModelByUserId(userId))!.toUserDataEntity(),
              )
              .toList(),
        );
        final ownerUserEntity =
            (await getUserModelByUserId(model.owner!))!.toUserDataEntity();

        final entity = model.toConfirmPostEntity(
          fetchResult.docs.first.reference.id,
          fanList,
          ownerUserEntity,
        );

        return Future(() => right(entity));
      }
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> uploadConfirmPost(ConfirmPostEntity entity) async {
    try {
      final model = FirebaseConfirmPostModel.fromConfirmPostEntity(entity);

      await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .add(model.toFirestoreMap());

      return Future(() => right(true));
    } on Exception catch (e) {
      return Future(
        () => left(Failure(e.toString())),
      );
    }
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity entity) async {
    try {
      final model = FirebaseConfirmPostModel.fromConfirmPostEntity(entity);

      await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .doc(entity.id)
          .update(model.toFirestoreMap());

      return Future(() => right(true));
    } on Exception catch (e) {
      return Future(
        () => left(Failure(e.toString())),
      );
    }
  }

  @override
  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionEntity,
  ) async {
    try {
      final reactionModel =
          FirebaseReactionModel.fromReactionEntity(reactionEntity);
      await firestore
          .collection(
            FirebaseCollectionName.getConfirmPostReactionCollectionName(
              targetConfirmPostId,
            ),
          )
          .add(reactionModel.toJson());

      await firestore
          .collection(
            FirebaseCollectionName.getUserReactionBoxCollectionName(
              reactionEntity.complimenterUid,
            ),
          )
          .add(reactionModel.toJson());

      return Future(() => right(true));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on sendReactionToTargetConfirmPost'),
        ),
      );
    }
  }

  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  ) async {
    try {
      final userDocument = await firestore
          .collection(
            FirebaseCollectionName.getTargetResolutionCollectionName(userId),
          )
          .get();

      final fetchResult = await Future.wait(
        userDocument.docs.map((doc) async {
          final model = FirebaseResolutionModel.fromFireStoreDocument(
            doc,
          );

          final fetchFanList = await Future.wait(
            (model.fanUserIdList ?? []).map((userId) async {
              final fetchResult =
                  (await fetchUserDataEntityByUserId(userId)).fold(
                (l) => null,
                (r) => r,
              );
              if (fetchResult != null) {
                return fetchResult;
              }
            }).toList(),
          );

          final fanUserEntityList = fetchFanList.whereNotNull().toList();

          final entity = model.toResolutionEntity(
            documentId: doc.reference.id,
            fanUserEntityList: fanUserEntityList,
          );

          return entity;
        }).toList(),
      );

      return Future(() => right(fetchResult));
    } on Exception {
      return Future(
        () =>
            left(const Failure('catch error on getActiveResolutionEntityList')),
      );
    }
  }

  @override
  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity) async {
    try {
      FirebaseResolutionModel resolutionModel =
          FirebaseResolutionModel.fromJson(entity.toJson());

      final List<String> fanList =
          (await firestore.collection(FirebaseCollectionName.friends).get())
              .docs
              .map((doc) => doc[FirebaseFriendFieldName.friendUid] as String)
              .toList();

      resolutionModel = resolutionModel.copyWith(fanUserIdList: fanList);

      await firestore
          .collection(FirebaseCollectionName.myResolutions)
          .add(resolutionModel.toJson());

      return Future(() => right(true));
    } on Exception {
      return Future(
        () => left(const Failure('catch error on uploadResolutionEntity')),
      );
    }
  }

  @override
  EitherFuture<UserDataEntity> fetchUserDataEntityByUserId(
    String targetUserId,
  ) async {
    try {
      final friendDocument = await firestore
          .collection(FirebaseCollectionName.users)
          .doc(targetUserId)
          .get();

      final model = FirebaseUserModel.fromFireStoreDocument(friendDocument);
      final entity = model.toUserDataEntity(
        userId: friendDocument.reference.id,
      );

      return Future(() => right(entity));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  Future<UserModel?> getUserModelByUserId(String targetUserId) async {
    try {
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

  @override
  EitherFuture<bool> deleteConfirmPost(ConfirmPostEntity entity) async {
    try {
      if (entity.owner != FirebaseAuth.instance.currentUser?.uid) {
        // 자신의 post가 아님
        return Future(
          () => left(const Failure('post is not owned by current user')),
        );
      }

      await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .doc(entity.id)
          .delete();

      return Future(() => right(true));
    } on Exception {
      return Future(
        () => left(const Failure('catch error on deleteConfirmPost')),
      );
    }
  }

  @override
  EitherFuture<String> getMyUserId() {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      return Future(() => right(userId));
    } on Exception {
      return Future(
        () => left(const Failure('catch error on deleteConfirmPost')),
      );
    }
  }

  @override
  EitherFuture<String> uploadPhotoFromLocalUrlToConfirmPost({
    required String confirmPostId,
    required String localPhotoUrl,
  }) async {
    try {
      String storagePath =
          '$confirmPostId/_${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().toIso8601String()}';
      final ref = FirebaseStorage.instance.ref(storagePath);

      await ref.putFile(File(localPhotoUrl));

      return Future(() async => right(await ref.getDownloadURL()));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<List<ReactionEntity>> getReactionsFromConfirmPost(
    ConfirmPostEntity entity,
  ) async {
    try {
      final reactions = await firestore
          .collection(
            FirebaseCollectionName.getConfirmPostReactionCollectionName(
              entity.id!,
            ),
          )
          .get();

      final reactionEntityList = await Future.wait(
        reactions.docs.map((doc) async {
          final reactionModel = FirebaseReactionModel.fromFireStoreDocument(doc)
              .toReactionEntity();

          return reactionModel;
        }).toList(),
      );

      return Future(() => right(reactionEntityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getUnreadReactions'),
        ),
      );
    }
  }

  @override
  EitherFuture<List<ReactionEntity>> getUnreadReactions() async {
    try {
      final fetchUid = (await getMyUserId()).fold((l) => null, (uid) => uid);

      if (fetchUid == null) {
        return Future(
          () => left(const Failure('unable to get firebase user id')),
        );
      }

      final reactions = await firestore
          .collection(
            FirebaseCollectionName.getUserReactionBoxCollectionName(fetchUid),
          )
          .get();

      final reactionEntityList = await Future.wait(
        reactions.docs.map((doc) async {
          await doc.reference.delete();
          final reactionModel = FirebaseReactionModel.fromFireStoreDocument(doc)
              .toReactionEntity();

          return reactionModel;
        }).toList(),
      );

      return Future(() => right(reactionEntityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getUnreadReactions'),
        ),
      );
    }
  }
}
