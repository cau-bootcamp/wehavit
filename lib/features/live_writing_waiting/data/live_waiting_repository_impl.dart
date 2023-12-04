import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';
import 'package:wehavit/features/live_writing_waiting/domain/repositories/live_waiting_repository.dart';

class LiveWaitingRepositoryImpl implements LiveWaitingRepository {
  LiveWaitingRepositoryImpl();

  static const String liveWaitingDocumentPrefix = 'WAIT-';
  static const WaitingUser user = WaitingUser();

  @override
  Future<bool> syncLiveWaitingUserStatus(DateTime nowTime) async {
    FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveWaitingUsers)
        .doc('$liveWaitingDocumentPrefix'
            '${FirebaseAuth.instance.currentUser!.uid}')
        .set(
          user.copyWith(updatedAt: nowTime).toJson(),
          SetOptions(merge: true),
        );

    debugPrint('SYNCED!');

    return true;
  }

  @override
  Stream<List<WaitingUser>> getLiveWaitingUsersStream() {
    try {
      print(
          '${FirebaseCollectionName.liveWaitingUsers}/$liveWaitingDocumentPrefix'
          '${FirebaseAuth.instance.currentUser!.uid}');
      final fetchResult = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.liveWaitingUsers)
          .where(
            FirebaseLiveWaitingFieldName.updatedAt,
            isGreaterThan: DateTime.now().subtract(
              const Duration(seconds: 10),
            ),
          )
          .snapshots();

      Stream<List<WaitingUser>> liveWaitingUsers = fetchResult
          .map((event) => event.docs)
          .map(
            (docs) =>
                docs.map((doc) => WaitingUser.fromJson(doc.data())).toList(),
          );

      return liveWaitingUsers;
    } on Exception {
      return const Stream.empty();
    }
  }
}
