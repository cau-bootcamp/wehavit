import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/data/models/firebase_models/group_announcement_model/firebase_group_announcement_model.dart';
import 'package:wehavit/data/models/models.dart';
import 'package:wehavit/domain/entities/entities.dart';

class FirebaseDatasourceImpl implements WehavitDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? myUid = FirebaseAuth.instance.currentUser?.uid;
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

      final uid = getMyUserId();

      // 사용자가 속한 그룹의 id List
      final groupIdList = await firestore
          .collection(FirebaseCollectionName.userGroups)
          .get()
          .then(
            (result) => result.docs
                .map((doc) => doc.data()['groupId'] as String)
                .toList(),
          );

      // 사용자가 속한 그룹에 속한 멤버들의 uid List
      final memberListForEachGroup = await Future.wait<List<String>>(
        groupIdList.map((groupId) async {
          return await firestore
              .collection(FirebaseCollectionName.groups)
              .doc(groupId)
              .get()
              .then(
                (value) => value
                    .data()?[FirebaseGroupFieldName.memberUidList]
                    ?.cast<String>(),
              );
        }),
      );

      // 그룹 멤버들이 해당 그룹에 공유한 목표들의 id List
      final groupResolutionIdList = (await Future.wait(
        memberListForEachGroup.mapIndexed((index, list) async {
          final groupId = groupIdList[index];
          final uidList = list;
          final resolutionIdList = (await Future.wait(
            uidList.map((uid) async {
              final resolutionIdList = await firestore
                  .collection(
                    FirebaseCollectionName.getTargetResolutionCollectionName(
                      uid,
                    ),
                  )
                  .where(
                    FirebaseResolutionFieldName.resolutionShareGroupIdList,
                    arrayContains: groupId,
                  )
                  .get()
                  .then(
                    (result) =>
                        result.docs.map((doc) => doc.reference.id).toList(),
                  );

              return resolutionIdList;
            }),
          ))
              .expand((element) => element)
              .toList();
          return resolutionIdList;
        }).toList(),
      ))
          .expand((element) => element)
          .toSet()
          .toList();

      // 친구들이 해당 그룹에 공유한 목표들의 id List
      // 사용자가 속한 그룹의 id List
      final friendIdList = await firestore
          .collection(
            FirebaseCollectionName.getTargetFriendsCollectionName(
              getMyUserId(),
            ),
          )
          .get()
          .then(
            (result) => result.docs
                .map(
                  (doc) =>
                      doc.data()[FirebaseFriendFieldName.friendUid] as String,
                )
                .toList(),
          );

      final friendResolutionIdList = (await Future.wait(
        friendIdList.map((uid) async {
          final resolutionIdList = await firestore
              .collection(
                  FirebaseCollectionName.getTargetResolutionCollectionName(uid))
              .where(
                FirebaseResolutionFieldName.resolutionShareFriendIdList,
                arrayContains: getMyUserId(),
              )
              .get()
              .then(
                (result) => result.docs.map((doc) {
                  return doc.reference.id;
                }).toList(),
              );
          return resolutionIdList;
        }),
      ))
          .expand((element) => element)
          .toSet()
          .toList();

      final wholeResolutionIdList =
          (groupResolutionIdList + friendResolutionIdList).toSet().toList();

      // query에 비어있는 리스트를 전달하면 에러가 발생하여, 예외처리 적용하였음
      if (wholeResolutionIdList.isEmpty) {
        return Future(
          () => right([]),
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
                FirebaseConfirmPostFieldName.resolutionId,
                whereIn: wholeResolutionIdList,
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

            final ownerUserEntity =
                (await getUserEntityByUserId(confirmPostModel.owner!))!;

            final entity = confirmPostModel.toConfirmPostEntity(
              doc.reference.id,
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

            final ownerUserEntity =
                (await getUserEntityByUserId(model.owner!))!;
            final entity = model.toConfirmPostEntity(
              doc.reference.id,
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
            .add(const Duration(days: 1)),
      );

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

        final ownerUserEntity = (await getUserEntityByUserId(model.owner!))!;

        final entity = model.toConfirmPostEntity(
          fetchResult.docs.first.reference.id,
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
            FirebaseCollectionName.getTargetUserReactionBoxCollectionName(
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
      final resolutionList = await firestore
          .collection(
            FirebaseCollectionName.getTargetResolutionCollectionName(userId),
          )
          .get()
          .then(
            (result) => Future.wait(
              result.docs.map((resolutionDocument) async {
                final model = FirebaseResolutionModel.fromFireStoreDocument(
                  resolutionDocument,
                );

                final shareFriendEntityList = (await Future.wait(
                  model.shareFriendIdList!.map((uid) async {
                    final entity = (await fetchUserDataEntityByUserId(uid))
                        .fold((failure) => null, (entity) => entity);

                    if (entity != null) {
                      return entity;
                    }
                  }).toList(),
                ))
                    .nonNulls
                    .toList();

                final shareGroupEntityList = (await Future.wait(
                  model.shareGroupIdList!.map((groupId) async {
                    final entity = (await fetchGroupEntityByGroupId(groupId))
                        .fold((failure) => null, (entity) => entity);

                    if (entity != null) {
                      return entity;
                    }
                  }).toList(),
                ))
                    .nonNulls
                    .toList();

                final resolutionEntity = model.toResolutionEntity(
                  documentId: resolutionDocument.reference.id,
                  shareFriendEntityList: shareFriendEntityList,
                  shareGroupEntityList: shareGroupEntityList,
                );

                return resolutionEntity;
              }).toList(),
            ),
          );

      return Future(() => right(resolutionList));
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
          FirebaseResolutionModel.fromEntity(entity);

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
  String getMyUserId() {
    if (myUid == null) {
      throw Exception('unable to get firebase user id');
    }
    return myUid!;
  }

  @override
  EitherFuture<String> uploadQuickShotFromLocalUrlToConfirmPost({
    required ConfirmPostEntity entity,
    required String localPhotoUrl,
  }) async {
    try {
      String storagePath =
          FirebaseCollectionName.getConfirmPostQuickShotReactionStorageName(
        entity.owner!,
        entity.id!,
      );
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
      final reactions = await firestore
          .collection(
            FirebaseCollectionName.userReactionBox,
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
      final uid = getMyUserId();
      String storagePath =
          FirebaseConfirmPostImagePathName.storagePath(uid: uid);
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
    required int groupColor,
    required DateTime groupCreatedAt,
  }) async {
    final groupModel = FirebaseGroupModel(
      groupName: groupName,
      groupDescription: groupDescription,
      groupRule: groupRule,
      groupManagerUid: groupManagerUid,
      groupMemberUidList: [groupManagerUid],
      groupColor: groupColor,
      groupCreatedAt: groupCreatedAt,
    );

    final groupId = (await firestore
            .collection(FirebaseCollectionName.groups)
            .add(groupModel.toJson()))
        .id;

    final entity = GroupEntity(
      groupName: groupModel.groupName,
      groupDescription: groupModel.groupDescription,
      groupRule: groupModel.groupRule,
      groupManagerUid: groupModel.groupManagerUid,
      groupMemberUidList: groupModel.groupMemberUidList,
      groupId: groupId,
      groupColor: groupColor,
      groupCreatedAt: groupCreatedAt,
    );

    firestore
        .collection(FirebaseCollectionName.userGroups)
        .add({'groupId': groupId});

    return Future(() => right(entity));
  }

  @override
  EitherFuture<void> applyForJoiningGroup(String groupId) async {
    final uid = getMyUserId();

    await firestore
        .collection(
      FirebaseCollectionName.getGroupApplyWaitingCollectionName(groupId),
    )
        .add({FirebaseGroupFieldName.applyUid: uid});

    return Future(() => right(null));
  }

  @override
  EitherFuture<void> processApplyingForGroup({
    required String groupId,
    required String uid,
    required bool isAccepted,
  }) async {
    try {
      final myUid = getMyUserId();

      final isManager = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(groupId)
          .get()
          .then(
            (value) =>
                value.data()?[FirebaseGroupFieldName.managerUid] == myUid,
          );

      if (!isManager) {
        debugPrint('current user is not a group manager');
        return Future(
          () => left(const Failure('current user is not a group manager')),
        );
      }

      firestore
          .collection(
            FirebaseCollectionName.getGroupApplyWaitingCollectionName(
              groupId,
            ),
          )
          .where(FirebaseGroupFieldName.applyUid, isEqualTo: uid)
          .get()
          .then(
            (data) => data.docs.map(
              (doc) async => await firestore
                  .collection(
                    FirebaseCollectionName.getGroupApplyWaitingCollectionName(
                      groupId,
                    ),
                  )
                  .doc(doc.id)
                  .delete(),
            ),
          );

      if (isAccepted) {
        firestore
            .collection(FirebaseCollectionName.groups)
            .doc(groupId)
            .update({
          FirebaseGroupFieldName.memberUidList: FieldValue.arrayUnion([uid]),
        });

        firestore
            .collection(FirebaseCollectionName.userGroups)
            .add({'groupId': groupId});
      }

      return Future(() => right(null));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<void> withdrawalFromGroup({required String groupId}) async {
    try {
      final myUid = getMyUserId();

      await firestore
          .collection(FirebaseCollectionName.userGroups)
          .where('groupId', isEqualTo: groupId)
          .get()
          .then((value) {
        value.docs.firstOption.fold(
          () => null,
          (t) => t.reference.delete(),
        );
      });

      firestore
          .collection(FirebaseCollectionName.userGroups)
          .where('groupId', isEqualTo: groupId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.map((doc) {
          doc.reference.delete();
        });
      });

      final remainings = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(groupId)
          .get()
          .then((group) {
        return group.data()?[FirebaseGroupFieldName.memberUidList]?.length;
      });

      // 현재 그룹에 남아있는 인원에 대한 데이터가 없는 경우
      if (remainings == null) {
        debugPrint('group does not exist');
        return Future(
          () => left(const Failure('group does not exist')),
        );
      }

      // 현재 그룹에 남아있는 인원이 한 명인 경우
      // 탈퇴와 동시에 그룹 삭제
      if (remainings == 1) {
        firestore
            .collection(
              FirebaseCollectionName.getGroupApplyWaitingCollectionName(
                groupId,
              ),
            )
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.map((doc) {
            doc.reference.delete();
          });
        }).then(
          (_) => firestore
              .collection(FirebaseCollectionName.groups)
              .doc(groupId)
              .delete(),
        );
      }
      // 현재 그룹에 남아있는 인원이 여러 명인 경우
      else if (remainings > 1) {
        firestore
            .collection(FirebaseCollectionName.groups)
            .doc(groupId)
            .update({
          FirebaseGroupFieldName.memberUidList: FieldValue.arrayRemove([myUid]),
        });
      }
      // 남은 인원이 음수인 경우는 없음
      else {
        return Future(
          () => left(const Failure('group member length cannot be 0')),
        );
      }
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }

    return Future(() => right(null));
  }

  EitherFuture<GroupEntity> fetchGroupEntityByGroupId(
    String targetGroupId,
  ) async {
    try {
      final groupDocument = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(targetGroupId)
          .get();

      final model = FirebaseGroupModel.fromFireStoreDocument(groupDocument);
      final entity = model.toGroupEntity(
        groupId: groupDocument.reference.id,
      );

      return Future(() => right(entity));
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<List<GroupEntity>> getGroupEntityList() async {
    try {
      final groupIdList = await firestore
          .collection(FirebaseCollectionName.userGroups)
          .get()
          .then(
            (result) => result.docs
                .map((doc) => doc.data()['groupId'].toString())
                .toList(),
          );

      final groupEntityList = (await Future.wait(
        groupIdList.map(
          (groupId) async {
            final fetchResult = await fetchGroupEntityByGroupId(groupId);
            final entity = fetchResult.fold(
              (l) => null,
              (entity) => entity,
            );
            if (entity != null) {
              return entity;
            }
          },
        ),
      ))
          .whereNotNull()
          .toList();

      return Future(() => right(groupEntityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on registerFriend'),
        ),
      );
    }
  }

  @override
  EitherFuture<void> changeGroupStateOfResolution({
    required String repositoryId,
    required String groupId,
    required bool toShareState,
  }) {
    try {
      if (toShareState == true) {
        firestore
            .collection(FirebaseCollectionName.myResolutions)
            .doc(repositoryId)
            .update({
          FirebaseResolutionFieldName.resolutionShareGroupIdList:
              FieldValue.arrayUnion([groupId]),
        });
      } else {
        firestore
            .collection(FirebaseCollectionName.myResolutions)
            .doc(repositoryId)
            .update({
          FirebaseResolutionFieldName.resolutionShareGroupIdList:
              FieldValue.arrayRemove([groupId]),
        });
      }

      return Future(() => right(null));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on changeGroupStateOfResolution'),
        ),
      );
    }
  }

  @override
  EitherFuture<void> uploadGroupAnnouncement(
    GroupAnnouncementEntity entity,
  ) async {
    try {
      final model = FirebaseGroupAnnouncementModel.fromEntity(entity);
      final myUid = getMyUserId();
      final hasPermission = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(entity.groupId)
          .get()
          .then((result) {
        final isMember = (result.data()![FirebaseGroupFieldName.memberUidList]
                as List<String>)
            .contains(myUid);
        final isManager =
            (result.data()![FirebaseGroupFieldName.managerUid] as String) ==
                myUid;

        // 공지글 작성 권한을 여기에서 수정할 수 있음!
        return isMember | isManager;
      });

      if (hasPermission == false) {
        return Future(
          () => left(
              Failure('User is not the member of group ${entity.groupId}')),
        );
      }

      firestore
          .collection(
            FirebaseCollectionName.getTargetGroupAnnouncemenetCollectionName(
              entity.groupId,
            ),
          )
          .add(model.toJson());

      return Future(() => right(null));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on uploadGroupAnnouncement'),
        ),
      );
    }
  }

  @override
  EitherFuture<List<GroupAnnouncementEntity>> getGroupAnnouncementEntityList(
    String groupId,
  ) async {
    try {
      final myUid = getMyUserId();
      final isMemberOfGroup = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(groupId)
          .get()
          .then(
            (result) => (result.data()![FirebaseGroupFieldName.memberUidList]
                    as List<dynamic>)
                .map((e) => e.toString())
                .contains(myUid),
          );

      if (isMemberOfGroup == false) {
        return Future(
          () => left(Failure('User is not the member of group $groupId')),
        );
      }

      final entityList = await firestore
          .collection(
            FirebaseCollectionName.getTargetGroupAnnouncemenetCollectionName(
              groupId,
            ),
          )
          .get()
          .then(
            (result) => result.docs.map((doc) {
              return FirebaseGroupAnnouncementModel.fromFireStoreDocument(doc)
                  .toEntity(announcementId: doc.reference.id);
            }).toList(),
          );
      return Future(() => right(entityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getGroupAnnouncementEntityList'),
        ),
      );
    }
  }

  @override
  EitherFuture<void> readGroupAnnouncement(
    GroupAnnouncementEntity entity,
  ) async {
    try {
      final myUid = getMyUserId();
      final isMemberOfGroup = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(entity.groupId)
          .get()
          .then(
            (result) => (result.data()![FirebaseGroupFieldName.memberUidList]
                    as List<dynamic>)
                .map((e) => e.toString())
                .contains(myUid),
          );

      if (isMemberOfGroup == false) {
        return Future(
          () => left(
              Failure('User is not the member of group ${entity.groupId}')),
        );
      }

      await firestore
          .collection(
            FirebaseCollectionName.getTargetGroupAnnouncemenetCollectionName(
              entity.groupId,
            ),
          )
          .doc(entity.groupAnnouncementId)
          .update(
        {
          FirebaseGroupAnnouncementFieldName.readByUidList:
              FieldValue.arrayUnion([getMyUserId()]),
        },
      );

      return Future(() => right(null));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on readGroupAnnouncement'),
        ),
      );
    }
  }

  @override
  EitherFuture<GroupWeeklyReportEntity> getGroupWeeklyReport(
    String groupId,
  ) async {
    try {
      // 현재가 월요일 10일 12:34:56이라면
      // StartDate 값은  3일 월요일 00:00:00 으로 설정
      // EndDate   값은 10일 월요일 00:00:00 으로 설정
      // -> start to end : 가장 최근의 월~일 (오늘이 일요일인 경우에는 이번 주)
      DateTime endDate;
      DateTime now = DateTime.now();
      int difference = now.weekday - DateTime.sunday;
      // 만약 현재 날짜가 일요일이면 현재 날짜를 반환
      if (difference == 0) {
        endDate =
            DateTime(now.year, now.month, now.day).add(const Duration(days: 2));
      } else {
        // 현재 날짜에서 일요일까지의 차이를 뺀 값을 반환
        final date = now.add(Duration(days: difference));
        endDate = DateTime(date.year, date.month, date.day)
            .add(const Duration(days: 2));
      }

      // ignore: unused_local_variable
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day)
          .subtract(const Duration(days: 7));

      // 그룹 맴버들에 대해서
      final memberList = (await firestore
              .collection(FirebaseCollectionName.groups)
              .doc(groupId)
              .get()
              .then(
                (result) async => await Future.wait(
                  (result.data()![FirebaseGroupFieldName.memberUidList]
                          as List<dynamic>)
                      .map((e) => e.toString())
                      .map((targetUid) async {
                    final fetchUserEntity =
                        await fetchUserDataEntityByUserId(targetUid).then(
                      (result) => result.fold(
                        (l) => null,
                        (entity) => entity,
                      ),
                    );

                    if (fetchUserEntity != null) {
                      return fetchUserEntity;
                    }
                  }).toList(),
                ),
              ))
          .nonNulls
          .toList();

      // 각 멤버들마다 Report cell을 생성
      final reportCellList = (await Future.wait(
        memberList.map((userEntity) async {
          // 각 멤버들이 이 그룹에 공유하는 목표 리스트를 먼저 가져와서
          final sharedResolutionList = await firestore
              .collection(
                FirebaseCollectionName.getTargetResolutionCollectionName(
                  userEntity.userId!,
                ),
              )
              .where(
                FirebaseResolutionFieldName.resolutionShareGroupIdList,
                arrayContains: groupId,
              )
              .get()
              .then(
                (result) async => await Future.wait(
                  result.docs.map((doc) async {
                    final shareFriendEntityList = (await Future.wait(
                      (doc.data()[FirebaseResolutionFieldName
                              .resolutionShareFriendIdList] as List<dynamic>)
                          .map((e) => e.toString())
                          .map((uid) async {
                        final entity = (await fetchUserDataEntityByUserId(uid))
                            .fold((failure) => null, (entity) => entity);

                        if (entity != null) {
                          return entity;
                        }
                      }).toList(),
                    ))
                        .nonNulls
                        .toList();

                    final shareGroupEntityList = (await Future.wait(
                      (doc.data()[FirebaseResolutionFieldName
                              .resolutionShareGroupIdList] as List<dynamic>)
                          .map((e) => e.toString())
                          .map((groupId) async {
                        final entity =
                            (await fetchGroupEntityByGroupId(groupId))
                                .fold((failure) => null, (entity) => entity);

                        if (entity != null) {
                          return entity;
                        }
                      }).toList(),
                    ))
                        .nonNulls
                        .toList();

                    return FirebaseResolutionModel.fromFireStoreDocument(doc)
                        .toResolutionEntity(
                      documentId: doc.reference.id,
                      shareFriendEntityList: shareFriendEntityList,
                      shareGroupEntityList: shareGroupEntityList,
                    );
                  }).toList(),
                ),
              );

          // 지난 기간동안의 인증글을 가져오기
          final doneListForWeek = (await Future.wait(
            sharedResolutionList.map((resolutionEntity) async {
              List<bool> doneListForWeek = List.generate(7, (_) => false);
              await firestore
                  .collection(FirebaseCollectionName.confirmPosts)
                  // .where(
                  //   FirebaseConfirmPostFieldName.createdAt,
                  //   isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
                  //   isLessThanOrEqualTo: Timestamp.fromDate(endDate),
                  // )
                  .get()
                  .then(
                    (result) => result.docs.map(
                      (doc) {
                        final weekday =
                            (doc.data()[FirebaseConfirmPostFieldName.createdAt]
                                    as Timestamp)
                                .toDate()
                                .weekday;
                        doneListForWeek[weekday] = true;
                      },
                    ).toList(),
                  );
              return doneListForWeek;
            }),
          ))
              .toList();

          // 각 목표의 달성 여부를 체크하고
          // {목표Id : T/F} 의 형식으로 map을 만들어 저장
          final successResolutionList =
              sharedResolutionList.mapWithIndex((resolution, index) {
            final numOfActionsForThisWeek = doneListForWeek[index]
                .where((element) => element == true)
                .length;

            return ((resolution.actionPerWeek ?? 7) <= numOfActionsForThisWeek)
                ? true
                : false;
          }).toList();

          final successResolutionMap = Map.fromIterables(
            sharedResolutionList.map((e) => e.resolutionId!),
            successResolutionList,
          );

          // 각 요일별로 인증 여부를 체크하고
          // [[월요일에 인증한 목표Id1, 월요일에 인증한 목표Id2], [화요일에 인증한 목표id3], [] ... ]
          // 의 형식으로 double list를 만들어 저장
          List<List<String>> doneResolutionIdListForEachDay =
              List.generate(7, (_) => []);

          doneListForWeek.mapWithIndex((doneForResolution, index) {
            doneForResolution.forEachIndexed((jndex, element) {
              if (element == true) {
                // 추가 안됨
                doneResolutionIdListForEachDay[jndex]
                    .append(sharedResolutionList[index].resolutionId!);

                // 추가 됨
                doneResolutionIdListForEachDay[jndex]
                    .add(sharedResolutionList[index].resolutionId!);
              }
            });
          }).toList();

          return GroupWeeklyReportCell(
            userEntity,
            sharedResolutionList,
            successResolutionMap,
            doneResolutionIdListForEachDay,
          );
        }),
      ))
          .toList();

      final reportEntity = GroupWeeklyReportEntity(
        groupId: groupId,
        groupWeeklyReportCellList: reportCellList,
      );
      return Future(() => right(reportEntity));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future(
        () => left(
          const Failure('catch error on getGroupWeeklyReport'),
        ),
      );
    }
  }

  @override
  EitherFuture<int> getGroupSharedResolutionCount(String groupId) async {
    try {
      final groupMemberUidList = await getGroupSharedMemberUidList(groupId);

      int sharedResolutionCounts = 0;

      await Future.wait(
        groupMemberUidList.map((memberUid) async {
          await firestore
              .collection(
                FirebaseCollectionName.getTargetResolutionCollectionName(
                  memberUid,
                ),
              )
              .where(
                FirebaseResolutionFieldName.resolutionShareGroupIdList,
                arrayContains: groupId,
              )
              .get()
              .then((value) {
            sharedResolutionCounts += value.docs.length;
          });
        }),
      );

      return Future(() => right(sharedResolutionCounts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getGroupSharedResolutionCount'),
        ),
      );
    }
  }

  @override
  EitherFuture<int> getGroupSharedPostCount(String groupId) async {
    try {
      final groupMemberUidList = await getGroupSharedMemberUidList(groupId);

      int sharedPostCounts = 0;

      await Future.wait(
        groupMemberUidList.map((memberUid) async {
          final resolutionIdList = await firestore
              .collection(
                FirebaseCollectionName.getTargetResolutionCollectionName(
                  memberUid,
                ),
              )
              .where(
                FirebaseResolutionFieldName.resolutionShareGroupIdList,
                arrayContains: groupId,
              )
              .get()
              .then((result) {
            return result.docs
                .map(
                  (doc) => doc.reference.id,
                )
                .toList();
          });

          if (resolutionIdList.isEmpty) {
            return;
          }

          await firestore
              .collection(FirebaseCollectionName.confirmPosts)
              .where(
                FirebaseConfirmPostFieldName.resolutionId,
                whereIn: resolutionIdList,
              )
              .get()
              .then((value) {
            sharedPostCounts += value.docs.length;
          });
        }),
      );

      return Future(() => right(sharedPostCounts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getGroupSharedPostCount'),
        ),
      );
    }
  }

  Future<List<String>> getGroupSharedMemberUidList(String groupId) async {
    try {
      final groupMemberUidList = firestore
          .collection(FirebaseCollectionName.groups)
          .doc(groupId)
          .get()
          .then(
            (result) => (result.data()![FirebaseGroupFieldName.memberUidList]
                    as List<dynamic>)
                .map((e) => e.toString())
                .toList(),
          );

      return groupMemberUidList;
    } on Exception {
      return Future(() => []);
    }
  }

  @override
  EitherFuture<GroupEntity> getGroupEntity({required String groupId}) async {
    try {
      final groupEntity = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(groupId)
          .get()
          .then(
            (result) =>
                FirebaseGroupModel.fromFireStoreDocument(result).toGroupEntity(
              groupId: groupId,
            ),
          );

      return Future(() => right(groupEntity));
    } on Exception {
      return Future(() => left(const Failure('cannot get group entity')));
    }
  }

  @override
  EitherFuture<bool> checkWhetherAlreadyAppliedToGroup({
    required String groupId,
  }) async {
    try {
      final uid = getMyUserId();

      final isApplied = await firestore
          .collection(
            FirebaseCollectionName.getGroupApplyWaitingCollectionName(
              groupId,
            ),
          )
          .where(FirebaseGroupFieldName.applyUid, isEqualTo: uid)
          .get()
          .then((result) => (result.docs.isNotEmpty ? true : false));

      return Future(() => right(isApplied));
    } on Exception {
      return Future(() => left(const Failure('cannot get applied status')));
    }
  }

  @override
  EitherFuture<bool> checkWhetherAlreadyRegisteredToGroup({
    required String groupId,
  }) async {
    try {
      final uid = getMyUserId();

      final isRegistered = await firestore
          .collection(FirebaseCollectionName.groups)
          .doc(groupId)
          .get()
          .then((result) {
        return List.castFrom(
          result.data()?[FirebaseGroupFieldName.memberUidList] as List,
        ).contains(uid);
      });

      return Future(() => right(isRegistered));
    } on Exception {
      return Future(() => left(const Failure('cannot get registered status')));
    }
  }

  @override
  EitherFuture<int> getTargetResolutionDoneCountForThisWeek({
    required String resolutionId,
  }) async {
    try {
      // 현재가 월요일 10일 12:34:56이라면
      // StartDate 값은 10일 월요일 00:00:00 으로 설정
      // EndDate   값은 17일 월요일 00:00:00 으로 설정
      // -> start to end : 가장 최근의 월~일 (오늘이 일요일인 경우에는 이번 주)
      DateTime endDate;
      DateTime now = DateTime.now();
      int difference = now.weekday - DateTime.sunday;
      // 만약 현재 날짜가 일요일이면 현재 날짜를 반환

      // 현재 날짜에서 일요일까지의 차이를 뺀 값을 반환
      final date = now.subtract(Duration(days: difference));
      endDate = DateTime(date.year, date.month, date.day)
          .add(const Duration(days: 1));

      // ignore: unused_local_variable
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day)
          .subtract(const Duration(days: 7));

      final doneCount = await firestore
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.resolutionId,
            isEqualTo: resolutionId,
          )
          .where(
            FirebaseConfirmPostFieldName.createdAt,
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
            isLessThanOrEqualTo: Timestamp.fromDate(endDate),
          )
          .get()
          .then(
            (value) => value.docs
                .where(
                  (element) =>
                      element.data()[FirebaseConfirmPostFieldName.attributes]
                          [FirebaseConfirmPostFieldName.attributesHasRested] ==
                      false,
                )
                .length,
          );

      return Future(() => right(doneCount));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future(
        () => left(
          const Failure(
            'catch error on getTargetResolutionDoneCountForThisWeek',
          ),
        ),
      );
    }
  }
}
