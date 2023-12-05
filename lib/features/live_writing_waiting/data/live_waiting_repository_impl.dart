import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';
import 'package:wehavit/features/live_writing_waiting/domain/repositories/live_waiting_repository.dart';

class LiveWaitingRepositoryImpl implements LiveWaitingRepository {
  LiveWaitingRepositoryImpl(this._friendRepository) {
    user = WaitingUser(
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
    List<FriendModel> friendList = const [],
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

  Future<List<FriendModel>> _getFriendList() async {
    final friendList =
        (await _friendRepository.getFriendModelList()).fold<List<FriendModel>>(
      (l) => [],
      (r) => r,
    );
    return friendList;
  }
}
