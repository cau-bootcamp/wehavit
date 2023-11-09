import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/data/datasources/confirm_post_remote_datasource_impl.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/live_writing/domain/repositories/confirm_post_repository.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(Ref ref) {
    _confirmPostRemoteDatasourceImpl = ref.watch(confirmPostDatasourceProvider);
  }

  late ConfirmPostDatasource _confirmPostRemoteDatasourceImpl;

  @override
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts() async {
    return await _confirmPostRemoteDatasourceImpl.getAllConfirmPosts();
  }

  @override
  EitherFuture<bool> createConfirmPost(ConfirmPostModel confirmPost) async {
    confirmPost = confirmPost.copyWith(
      roles: {
        FirebaseAuth.instance.currentUser!.uid: 'owner',
      },
    );

    try {
      _confirmPostRemoteDatasourceImpl.createConfirmPost(confirmPost);
    } catch (e) {
      return Future(() => left(const Failure('createConfirmPost failed')));
    }

    return Future(() => right(true));
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
      DocumentReference<ConfirmPostModel> confirmPostRef) {
    // TODO: implement deleteConfirmPost
    return Future(
        () => left(const Failure('deleteConfirmPost not implemented')));
  }

  @override
  EitherFuture<ConfirmPostModel> getConfirmPostByUserId(String userId) {
    // TODO: implement getConfirmPostByUserId
    return Future(
        () => left(const Failure('getConfirmPostByUserId not implemented')));
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost) {
    // TODO: implement updateConfirmPost
    return Future(
        () => left(const Failure('updateConfirmPost not implemented')));
  }
}
