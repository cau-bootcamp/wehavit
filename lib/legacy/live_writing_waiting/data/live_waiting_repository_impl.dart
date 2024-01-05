import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';
import 'package:wehavit/legacy/repository/live_waiting_repository.dart';
import 'package:wehavit/legacy/waiting_user_entity/waiting_user_model.dart';

class LiveWaitingRepositoryImpl implements LiveWaitingRepository {
  LiveWaitingRepositoryImpl(this._friendRepository) {
    user = WaitingUser(
      name: FirebaseAuth.instance.currentUser!.displayName!,
      userId: FirebaseAuth.instance.currentUser!.uid,
      email: FirebaseAuth.instance.currentUser!.email!,
      imageUrl: FirebaseAuth.instance.currentUser!.photoURL,
    );
  }

  static const String liveWaitingDocumentPrefix = 'WAIT-';
  late final WaitingUser user;
  final FriendRepository _friendRepository;

  @override
  Future<bool> syncLiveWaitingUserStatus(DateTime nowTime) async {
    FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveWaitingUsers)
        .doc('$liveWaitingDocumentPrefix'
            '${user.email}')
        .set(
          user.copyWith(updatedAt: nowTime).toJson(),
          SetOptions(merge: true),
        );

    return true;
  }

  @override
  Future<Stream<List<WaitingUser>>> getLiveWaitingUsersStream({
    List<UserDataEntity> friendList = const [],
  }) async {
    friendList = await _getFriendList();

    final friendEmails = friendList.map((e) => e.friendEmail);
    // debugPrint('FriendList: $friendEmails');

    if (friendEmails.isEmpty) {
      return Stream.value([]);
    }

    try {
      final fetchResult = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.liveWaitingUsers)
          .where(
            FirebaseLiveWaitingFieldName.updatedAt,
            isGreaterThan: DateTime.now().subtract(
              const Duration(seconds: 10),
            ),
          )
          .where(
            FirebaseLiveWaitingFieldName.email,
            whereIn: friendEmails,
          )
          .snapshots();

      Stream<List<WaitingUser>> liveWaitingUsers = fetchResult
          .map((event) => event.docs)
          .map(
            (docs) =>
                docs.map((doc) => WaitingUser.fromJson(doc.data())).toList(),
          );

      return liveWaitingUsers;
    } on Exception catch (e) {
      debugPrint('getLiveWaitingUsersStream: $e');
      return const Stream.empty();
    }
  }

  Future<List<UserDataEntity>> _getFriendList() async {
    final friendList = (await _friendRepository.getFriendModelList())
        .fold<List<UserDataEntity>>(
      (l) => [],
      (r) => r,
    );
    return friendList;
  }
}
