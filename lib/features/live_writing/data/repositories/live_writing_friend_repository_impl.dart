import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_friend_repository.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

class LiveWritingFriendRepositoryImpl extends LiveWritingFriendRepository {
  LiveWritingFriendRepositoryImpl();

  final livePostDocumentPrefix = 'LIVE-';

  @override
  Future<List<String>> getVisibleFriendEmailList() async {
    final friendsSnapshots = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.friends)
        .get();

    final friendsAccepted = friendsSnapshots.docs;

    // TODO. 친구 수락이 구현될 경우 사용
    // final int friendStateAccepted = 1;
    // friendsAccepted.where((data) {
    //   return data.data()['friendState'] == friendStateAccepted;
    // });

    return friendsAccepted.map<String>((data) {
      return data.data()[FirebaseFriendFieldName.friendEmail];
    }).toList();
  }

  @override
  Stream<String> getFriendMessageLiveByEmail(String email) {
    final stream = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$email')
        .snapshots()
        .map(
          (event) =>
              event.data()![FirebaseLiveConfirmPostFieldName.message] as String,
        );

    return stream;
  }

  @override
  Stream<String> getFriendTitleLiveByEmail(String email) {
    final stream = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$email')
        .snapshots()
        .map(
          (event) =>
              event.data()![FirebaseLiveConfirmPostFieldName.title] as String,
        );

    return stream;
  }

  @override
  Stream<String> getFriendPostImageLiveByEmail(String email) {
    final stream = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$email')
        .snapshots()
        .map(
          (event) => event.data()![FirebaseLiveConfirmPostFieldName.imageUrl]
              as String,
        );

    return stream;
  }

  @override
  Future<String> getFriendProfileImageUrlByEmail(String email) {
    final res = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseUserFieldName.email, isEqualTo: email)
        .get()
        .then<String>(
      (value) {
        return value.docs.first.data()[FirebaseUserFieldName.imageUrl];
      },
    );
    return res;
  }

  @override
  Future<String> getFriendMessageOnceByEmail(String email) async {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionName.liveConfirmPosts)
        .doc('$livePostDocumentPrefix$email')
        .get()
        .then(
      (value) {
        return value.data()![FirebaseLiveConfirmPostFieldName.message]
            as String;
      },
    );
  }

  @override
  Future<String> getFriendNameOnceByEmail(String email) {
    final res = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseUserFieldName.email, isEqualTo: email)
        .get()
        .then<String>(
      (value) {
        return value.docs.first.data()[FirebaseUserFieldName.displayName];
      },
    );
    return res;
  }

  @override
  EitherFuture<bool> sendReactionToTargetFriend(
    String targetEmail,
    ReactionModel reactionModel,
  ) async {
    const errorMessage = 'Error on sendReactionToTargetFriend Function';
    reactionModel = reactionModel.copyWith(
      complimenterUid: '/users/${FirebaseAuth.instance.currentUser!.uid}',
      hasRead: false,
    );

    try {
      await FirebaseFirestore.instance
          .collection(
            '${FirebaseCollectionName.liveConfirmPosts}/$livePostDocumentPrefix$targetEmail/${FirebaseCollectionName.encourages}',
          )
          .add(
            reactionModel.toJson(),
          );

      return Future(() => right(true));
    } on Exception {
      debugPrint(errorMessage);
      return Future(
        () => left(
          const Failure(errorMessage),
        ),
      );
    }
  }
}
