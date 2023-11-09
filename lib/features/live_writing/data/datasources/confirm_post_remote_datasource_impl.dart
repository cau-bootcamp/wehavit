import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
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
            isEqualTo: CONFIRM_POST_ROLES_COMPILIMENTER,
          )
          .get();

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
  EitherFuture<bool> createConfirmPost(ConfirmPostModel confirmPost) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .add(confirmPost.toJson());

    return Future(() => right(true));
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
      DocumentReference<ConfirmPostModel> ref) {
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

// TODO. move to different file
abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts();

  EitherFuture<bool> createConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> deleteConfirmPost(DocumentReference<ConfirmPostModel> ref);

  EitherFuture<bool> getConfirmPostByUserId(String userId);
}

// TODO. move to different file
final confirmPostDatasourceProvider = Provider<ConfirmPostDatasource>((ref) {
  return ConfirmPostRemoteDatasourceImpl();
});
