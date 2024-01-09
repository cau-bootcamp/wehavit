import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/firebase_datasource_impl.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ConfirmPostRepositoryImpl(wehavitDatasource);
});

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost) async {
    final String resolutionId = confirmPost.resolutionId!;
    try {
      final existingPost = await _wehavitDatasource
          .getConfirmPostOfTodayByResolutionGoalId(resolutionId);

      existingPost.fold(
        (l) {
          // create new post if not exist
          confirmPost = confirmPost.copyWith(
            owner: FirebaseAuth.instance.currentUser!.uid,
          );

          _wehavitDatasource.uploadConfirmPost(confirmPost);
        },
        (cf) {
          // update existing post
          confirmPost = confirmPost.copyWith(
            id: cf.id,
            owner: FirebaseAuth.instance.currentUser!.uid,
            createdAt: cf.createdAt,
            updatedAt: DateTime.now(),
          );

          _wehavitDatasource.updateConfirmPost(confirmPost);
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
  EitherFuture<ConfirmPostEntity> getConfirmPostEntityByUserId({
    required String userId,
  }) {
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
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
      {required String resolutionId}) {
    // TODO: implement getConfirmPostListForResolutionId
    throw UnimplementedError();
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate({
    required int selectedDate,
  }) async {
    try {
      final getResult = await _wehavitDatasource.getConfirmPostEntityList(
        selectedDate,
      );

      return getResult.fold((failure) => left(failure), (entityList) {
        final modelList = entityList.toList();

        return Future(() => right(modelList));
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
