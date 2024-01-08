import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/presentation/friend_list/data/datasources/friend_datasource.dart';
import 'package:wehavit/presentation/friend_list/data/entities/add_friend_entity.dart';
import 'package:wehavit/presentation/friend_list/data/entities/friend_entity.dart';

final friendDatasourceProvider = Provider<FriendDatasource>((ref) {
  return FriendRemoteDatasourceImpl();
});

class FriendRemoteDatasourceImpl implements FriendDatasource {
  @override
  EitherFuture<List<FriendEntity>> getFriendEntityList() async {
    List<FriendEntity> friendEntityList;

    try {
      final friendsSnapshots = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.friends)
          .get();

      // friend state가 1인 경우에만 해당 email을 friendsEmail에 추가
      // state가 1인 것은 친구인 상태, 0인 것은 친구를 신청한 상태이다.
      final friendEmails = friendsSnapshots.docs
          .map((doc) {
            // 주석 아래 if문을 바로 두 문장으로 변경하면 friend state가 1인 경우의 친구의 정보만 가져옵니다.
            //  if (doc.data()[FirebaseFieldName.friendState] == 1 &&
            //      doc.data()[FirebaseFieldName.friendEmail] != null) {
            if (doc.data()[FirebaseFriendFieldName.friendEmail] != null) {
              return doc.data()[FirebaseFriendFieldName.friendEmail] as String;
            }
            return null;
          })
          .where((email) => email != null)
          .cast<String>()
          .toList();

      friendEntityList = [];
      if (friendEmails.isNotEmpty) {
        // email을 기반으로 users collection에서 where로 검색하여 친구의 문서를 가지고 온다.
        final friendDocSnapshots = await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.users)
            .where(FirebaseUserFieldName.email, whereIn: friendEmails)
            .get();

        friendEntityList = friendDocSnapshots.docs
            .map((doc) => FriendEntity.fromFirebaseDocument(doc.data()))
            .toList();
      }
      return Future(() => right(friendEntityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveFriendEntityList'),
        ),
      );
    }
  }

  @override
  EitherFuture<bool> uploadAddFriendEntity(
    AddFriendEntity entity,
  ) async {
    final friendsDocsSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.friends)
        .where(
          FirebaseFriendFieldName.friendEmail,
          isEqualTo: entity.friendEmail,
        )
        .get();
    if (friendsDocsSnapshot.docs.isNotEmpty ||
        FirebaseAuth.instance.currentUser?.email == entity.friendEmail) {
      return Future(
        () => left(
          const Failure('There is same user in friends list'),
        ),
      );
    }

    final friendSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(
          FirebaseUserFieldName.email,
          isEqualTo: entity.friendEmail,
        )
        .limit(1)
        .get();
    final friendRef = friendSnapshot.docs.map((doc) => doc.id).toList();

    if (friendRef.isNotEmpty) {
      try {
        final Map<String, dynamic> doc = {};
        doc[FirebaseFriendFieldName.friendEmail] =
            FirebaseAuth.instance.currentUser?.email;
        doc[FirebaseFriendFieldName.friendState] = 0;

        // 친구 추가
        FirebaseFirestore.instance
            .collection(FirebaseCollectionName.friends)
            .add(entity.toFirebaseDocument());
        // 친구에게 내 정보 추가
        FirebaseFirestore.instance
            .collection(
              FirebaseCollectionName.getTargetFriendsCollection(
                friendRef[0],
              ),
            )
            .add(doc);
        return Future(() => right(true));
      } on Exception {
        return Future(
          () => left(
            const Failure('catch error on uploadFriendEntity'),
          ),
        );
      }
    } else {
      return Future(
        () => left(
          const Failure('There is no friend Email'),
        ),
      );
    }
  }
}
