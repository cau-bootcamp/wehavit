import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';
import 'package:wehavit/presentation/live_writing/data/data.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(Ref ref) {
    _confirmPostRemoteDatasourceImpl = ref.watch(confirmPostDatasourceProvider);
  }

  late ConfirmPostDatasource _confirmPostRemoteDatasourceImpl;

  @override
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts() async {
    return await _confirmPostRemoteDatasourceImpl.getAllFanMarkedConfirmPosts();
  }

  @override
  EitherFuture<bool> createConfirmPost(ConfirmPostModel confirmPost) async {
    final String resolutionId = confirmPost.resolutionId!;
    try {
      final existingPost = await _confirmPostRemoteDatasourceImpl
          .getConfirmPostOfTodayByResolutionGoalId(resolutionId);

      existingPost.fold(
        (l) {
          // create new post if not exist
          confirmPost = confirmPost.copyWith(
            owner: FirebaseAuth.instance.currentUser!.uid,
          );

          _confirmPostRemoteDatasourceImpl.uploadConfirmPost(confirmPost);
        },
        (cf) {
          // update existing post
          confirmPost = confirmPost.copyWith(
            id: cf.id,
            owner: FirebaseAuth.instance.currentUser!.uid,
            createdAt: cf.createdAt,
            updatedAt: DateTime.now(),
          );

          _confirmPostRemoteDatasourceImpl.updateConfirmPost(confirmPost);
        },
      );

      return Future(() => right(true));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'FirebaseException'));
    }
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostModel> confirmPostRef,
  ) {
    // TODO: implement deleteConfirmPost
    return Future(
      () => left(const Failure('deleteConfirmPost not implemented')),
    );
  }

  @override
  EitherFuture<ConfirmPostModel> getConfirmPostByUserId(String userId) {
    // TODO: implement getConfirmPostByUserId
    return Future(
      () => left(const Failure('getConfirmPostByUserId not implemented')),
    );
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost) {
    return Future(
      () => left(const Failure('updateConfirmPost not implemented')),
    );
  }

  @override
  EitherFuture<List<HomeConfirmPostModel>> getConfirmPostModelList(
      int selectedIndex) {
    // TODO: implement getConfirmPostModelList
    throw UnimplementedError();
  }
}
