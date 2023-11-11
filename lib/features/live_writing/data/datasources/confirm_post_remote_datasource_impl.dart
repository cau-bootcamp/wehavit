import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/data/datasources/datasources.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  // TODO. move to constants
  static const CONFIRM_POST_COLLECTION = 'confirm_posts';
  static const CONFIRM_POST_ROLES_COMPILIMENTER = 'complimenter';
  static const CONFIRM_POST_ROLES_OWNER = 'owner';

  @override
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts() async {
    try {
      // print(FirebaseAuth.instance.currentUser!.uid);
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
