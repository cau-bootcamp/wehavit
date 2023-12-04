import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';
import 'package:wehavit/features/live_writing_waiting/domain/repositories/live_waiting_repository.dart';

class LiveWaitingRepositoryImpl implements LiveWaitingRepository {
  LiveWaitingRepositoryImpl();

  static const String liveWaitingDocumentPrefix = 'WAIT-';

  @override
  EitherFuture<bool> syncLiveWaitingUserStatus(WaitingUser user) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .add(user.toJson());

    return Future(() => right(true));
  }

  @override
  EitherFuture<Stream<List<WaitingUser>>> getLiveWaitingUsersStream() {
    try {
      final fetchResult = FirebaseFirestore.instance
          .collection(
            '${FirebaseCollectionName.liveWaitingUsers}/$liveWaitingDocumentPrefix'
            '${FirebaseAuth.instance.currentUser!.uid}',
          )
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

      return Future(() => right(liveWaitingUsers));
    } on Exception {
      return Future(
        () => left(
          const Failure(
            'Failed to get live waiting users stream.',
          ),
        ),
      );
    }
  }
}
