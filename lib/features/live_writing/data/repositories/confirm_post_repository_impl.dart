import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/data/data.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

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
      owner: FirebaseAuth.instance.currentUser!.uid,
    );
    try {
      _confirmPostRemoteDatasourceImpl.createConfirmPost(confirmPost);
      return Future(() => right(true));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'FirebaseException'));
    }
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
