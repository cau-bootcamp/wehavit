import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';
import 'package:wehavit/legacy/live_writing/live_writing.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(Ref ref) {
    _confirmPostRemoteDatasourceImpl = ref.watch(
        liveWritingConfirmPostDatasourceProvider
            as AlwaysAliveProviderListenable<ConfirmPostDatasource>);
  }

  late ConfirmPostDatasource _confirmPostRemoteDatasourceImpl;

  @override
  EitherFuture<List<ConfirmPostEntity>> getAllConfirmPosts() async {
    return await _confirmPostRemoteDatasourceImpl.getAllFanMarkedConfirmPosts();
  }

  @override
  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost) async {
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
    DocumentReference<ConfirmPostEntity> confirmPostRef,
  ) {
    // TODO: implement deleteConfirmPost
    return Future(
      () => left(const Failure('deleteConfirmPost not implemented')),
    );
  }

  @override
  EitherFuture<ConfirmPostEntity> getConfirmPostByUserId(String userId) {
    // TODO: implement getConfirmPostByUserId
    return Future(
      () => left(const Failure('getConfirmPostByUserId not implemented')),
    );
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost) {
    return Future(
      () => left(const Failure('updateConfirmPost not implemented')),
    );
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostModelList(
      int selectedIndex) {
    // TODO: implement getConfirmPostModelList
    throw UnimplementedError();
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostListForResolutionId(
      {required String resolutionId}) {
    // TODO: implement getConfirmPostListForResolutionId
    throw UnimplementedError();
  }
}
