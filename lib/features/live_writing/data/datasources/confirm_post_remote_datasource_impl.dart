import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/data/data.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  // TODO. move to constants
  static const CONFIRM_POST_COLLECTION = 'confirm_posts';
  static const CONFIRM_POST_FIELD_FAN = 'fan';
  static const CONFIRM_POST_FIELD_OWNER = 'owner';

  @override
  EitherFuture<List<ConfirmPostModel>> getAllFanMarkedConfirmPosts() async {
    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(
            CONFIRM_POST_COLLECTION,
          )
          .where(
            CONFIRM_POST_FIELD_FAN,
            arrayContains: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();

      // debugPrint(fetchResult.docs.length.toString());

      // List<ConfirmPostModel> confirmPosts = fetchResult.docs
      //     .map((doc) => ConfirmPostModel.fromFireStoreDocument(doc))
      //     .toList();

      // DUMMY DATA
      final confirmPosts = [
        ConfirmPostModel(
          resolutionGoalStatement: '맛있는걸 많이 먹자',
          resolutionId: FirebaseFirestore.instance.doc(
              "users/g3TQoeVVc9VWMrD4uW7O2UzxdbG3/resolutions/7f91sVOSwUu9c7hlWan0"),
          title: '커피를 마시자',
          content:
              '커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 ',
          imageUrl: "https://i2.ruliweb.com/cmt/21/08/24/17b7623fa15508040.jpg",
          recentStrike: 65,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          attributes: {},
          owner: '69dlXoGSBKhzrySuhb8t9MvqzdD3',
          fan: [],
        ),
        ConfirmPostModel(
          resolutionGoalStatement: '맛있는걸 많이 먹자2',
          resolutionId: FirebaseFirestore.instance.doc(
              "users/g3TQoeVVc9VWMrD4uW7O2UzxdbG3/resolutions/7f91sVOSwUu9c7hlWan0"),
          title: '커피를 마시자2',
          content:
              '222커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어 커피는 맛있어 와인도 맛있어',
          imageUrl: "https://i2.ruliweb.com/cmt/21/08/24/17b7623fa15508040.jpg",
          recentStrike: 65,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          owner: '69dlXoGSBKhzrySuhb8t9MvqzdD3',
          fan: [],
          attributes: {},
        ),
      ];

      return Future(() => right(confirmPosts));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveResolutionEntityList'),
        ),
      );
    }
  }

  @override
  EitherFuture<bool> uploadConfirmPost(ConfirmPostModel confirmPost) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .add(confirmPost.toJson());

    return Future(() => right(true));
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostModel> ref,
  ) {
    // TODO: implement deleteConfirmPost
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> getConfirmPostByUserId(String userId) {
    // TODO: implement getConfirmPostByUserId
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost) {
    // TODO: implement updateConfirmPost
    throw UnimplementedError();
  }
}
