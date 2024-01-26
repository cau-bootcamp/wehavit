import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/data/models/firebase_group_model.dart';
import 'package:wehavit/data/models/models.dart';
import 'package:wehavit/domain/entities/entities.dart';

class FirebaseDatasourceImpl implements WehavitDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int get maxDay => 27;

  @override
  EitherFuture<List<UserDataEntity>> getFriendModelList() async {
    // users에서 내 user 정보 접근해서 friends 리스트 받아오기
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final friendDocument =
          await firestore.collection(FirebaseCollectionName.friends).get();

      List<UserDataEntity?> fetchResult = await Future.wait(
        friendDocument.docs.map((doc) async {
          return getUserEntityByUserId(
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

      final uid = (await getMyUserId()).fold(
        (l) => null,
        (uid) => uid,
      );

      if (uid == null) {
        return Future(
          () => left(const Failure('unable to get firebase user id')),
        );
      }

      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.createdAt,
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
            isLessThanOrEqualTo: Timestamp.fromDate(endDate),
          )
          .where(
            Filter.or(
              Filter(
                FirebaseConfirmPostFieldName.fan,
                arrayContains: uid,
              ),
              Filter(
                FirebaseConfirmPostFieldName.owner,
                isEqualTo: uid,
              ),
            ),
          )
          .get();

      List<ConfirmPostEntity> confirmPosts = await Future.wait(
        fetchResult.docs.map(
          (doc) async {
            final confirmPostModel =
                FirebaseConfirmPostModel.fromFireStoreDocument(doc);
            final fanList = await Future.wait(
              confirmPostModel.fan!
                  .map(
                    (userId) async => (await getUserEntityByUserId(userId))!,
                  )
                  .toList(),
            );
            final ownerUserEntity =
                (await getUserEntityByUserId(confirmPostModel.owner!))!;

            final entity = confirmPostModel.toConfirmPostEntity(
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
      return Future(
        () => left(
          Failure('catch error on getConfirmPostEntityList - $e'),
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
                    (userId) async => (await getUserEntityByUserId(userId))!,
                  )
                  .toList(),
            );
            final ownerUserEntity =
                (await getUserEntityByUserId(model.owner!))!;
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
      final DateTime today = DateTime.now();

      Timestamp startDate =
          Timestamp.fromDate(DateTime(today.year, today.month, today.day));

      Timestamp endDate = Timestamp.fromDate(
          DateTime(today.year, today.month, today.day)
              .add(const Duration(days: 1)));

      final fetchResult = await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.resolutionId,
            isEqualTo: resolutionId,
          )
          .where(
            FirebaseConfirmPostFieldName.createdAt,
            isGreaterThanOrEqualTo: startDate,
            isLessThanOrEqualTo: endDate,
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
                (userId) async => (await getUserEntityByUserId(userId))!,
              )
              .toList(),
        );
        final ownerUserEntity = (await getUserEntityByUserId(model.owner!))!;

        final entity = model.toConfirmPostEntity(
          fetchResult.docs.first.reference.id,
          fanList,
          ownerUserEntity,
        );

        return Future(() => right(entity));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
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
    ConfirmPostEntity targetEntity,
    ReactionEntity reactionEntity,
  ) async {
    try {
      final reactionModel =
          FirebaseReactionModel.fromReactionEntity(reactionEntity);
      await firestore
          .collection(
            FirebaseCollectionName.getConfirmPostReactionCollectionName(
              targetEntity.id!,
            ),
          )
          .add(reactionModel.toJson());

      await firestore
          .collection(
            FirebaseCollectionName.getUserReactionBoxCollectionName(
              targetEntity.owner!,
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
    } on Exception catch (e) {
      debugPrint(e.toString());
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

  Future<UserDataEntity?> getUserEntityByUserId(String targetUserId) async {
    try {
      final friendDocument = await firestore
          .collection(FirebaseCollectionName.users)
          .doc(targetUserId)
          .get();

      final result = FirebaseUserModel.fromFireStoreDocument(friendDocument)
          .toUserDataEntity(userId: targetUserId);

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
  EitherFuture<String> uploadQuickShotFromLocalUrlToConfirmPost({
    required ConfirmPostEntity entity,
    required String localPhotoUrl,
  }) async {
    try {
      String storagePath =
          FirebaseCollectionName.getConfirmPostQuickShotReactionStorageName(
              entity.owner!, entity.id!);
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
  EitherFuture<List<ReactionEntity>> getUnreadReactionsAndDelete() async {
    try {
      final fetchUid = (await getMyUserId()).fold(
        (l) => null,
        (uid) => uid,
      );

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

  @override
  EitherFuture<String> uploadConfirmPostImageFromLocalUrl(
    String localFileUrl,
  ) async {
    try {
      final getUidResult = (await getMyUserId()).fold(
        (l) => null,
        (uid) => uid,
      );

      if (getUidResult == null) {
        return Future(() => left(const Failure('cannot get uid')));
      }

      String storagePath =
          '$getUidResult/confirm_post/_${DateTime.now().toIso8601String()}';
      final ref = FirebaseStorage.instance.ref(storagePath);

      await ref.putFile(File(localFileUrl));

      return Future(() async => right(await ref.getDownloadURL()));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<GroupEntity> createGroup({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
  }) async {
    final groupModel = FirebaseGroupModel(
      groupName: groupName,
      groupDescription: groupDescription,
      groupRule: groupRule,
      groupManagerUid: groupManagerUid,
      groupMembers: [groupManagerUid],
    );

    final documentId = (await firestore
            .collection(FirebaseCollectionName.groups)
            .add(groupModel.toJson()))
        .id;

    final entity = GroupEntity(
      groupName: groupModel.groupName,
      groupDescription: groupModel.groupDescription,
      groupRule: groupModel.groupRule,
      groupManagerUid: groupModel.groupManagerUid,
      groupMemberUid: groupModel.groupMembers,
      groupId: documentId,
    );

    return Future(() => right(entity));
  }

  @override
  EitherFuture<void> applyForJoiningGroup(String groupId) async {
    final getUidResult = (await getMyUserId()).fold(
      (l) => null,
      (uid) => uid,
    );

    if (getUidResult == null) {
      return Future(() => left(const Failure('cannot get uid')));
    }

    await firestore
        .collection(
            FirebaseCollectionName.getGroupApplyWaitingCollectionName(groupId))
        .add({'uid': getUidResult});

    return Future(() => right(null));
  }
}
