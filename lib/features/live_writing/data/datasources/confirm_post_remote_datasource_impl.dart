import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  // TODO. move to constants
  static const CONFIRM_POST_COLLECTION = 'confirm_posts';
  static const CONFIRM_POST_ROLES_COMPILIMENTER = 'complimenter';
  static const CONFIRM_POST_ROLES_OWNER = 'owner';

  @override
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts() async {
    try {
      // final fetchResult = await FirebaseFirestore.instance
      //     .collection(
      //       CONFIRM_POST_COLLECTION,
      //     )
      //     .where(
      //       _getRolePath(FirebaseAuth.instance.currentUser!.uid),
      //       isEqualTo: 'owner',
      //     )
      //     .get();

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
          roles: {"69dlXoGSBKhzrySuhb8t9MvqzdD3": "owner"},
          attributes: {},
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
          roles: {"69dlXoGSBKhzrySuhb8t9MvqzdD3": "owner"},
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

  String _getRolePath(uid) => 'roles.$uid';

  @override
  void createConfirmPost() {
    // TODO: implement createConfirmPost
  }

  @override
  void deleteConfirmPost() {
    // TODO: implement deleteConfirmPost
  }

  @override
  void getConfirmPostByUserId() {
    // TODO: implement getConfirmPostByUserId
  }

  @override
  void updateConfirmPost() {
    // TODO: implement updateConfirmPost
  }
}

// TODO. move to different file
abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts();

  void createConfirmPost();

  void updateConfirmPost();

  void deleteConfirmPost();

  void getConfirmPostByUserId();
}

// TODO. move to different file
final confirmPostDatasourceProvider = Provider<ConfirmPostDatasource>((ref) {
  return ConfirmPostRemoteDatasourceImpl();
});
