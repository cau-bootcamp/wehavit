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
      final fetchResult = await FirebaseFirestore.instance
          .collection(
            CONFIRM_POST_COLLECTION,
          )
          .where(
            _getRolePath(FirebaseAuth.instance.currentUser!.uid),
            isEqualTo: 'owner',
          )
          .get();

      debugPrint(fetchResult.docs.length.toString());

      List<ConfirmPostModel> confirmPosts = fetchResult.docs
          .map((doc) => ConfirmPostModel.fromFireStoreDocument(doc))
          .toList();

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
