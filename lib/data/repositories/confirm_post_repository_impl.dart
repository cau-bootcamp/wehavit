import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<bool> createConfirmPost(
    ConfirmPostEntity confirmPostEntity,
  ) async {
    final String resolutionId = confirmPostEntity.resolutionId!;
    try {
      final existingPost = await _wehavitDatasource
          .getConfirmPostOfTodayByResolutionGoalId(resolutionId);

      existingPost.fold(
        (l) {
          // create new post if not exist
          _wehavitDatasource.uploadConfirmPost(confirmPostEntity);
        },
        (cf) {
          // update existing post
          confirmPostEntity = confirmPostEntity.copyWith(
            id: cf.id,
            owner: FirebaseAuth.instance.currentUser!.uid,
            createdAt: cf.createdAt,
            updatedAt: DateTime.now(),
          );

          _wehavitDatasource.updateConfirmPost(confirmPostEntity);
        },
      );

      return Future(() => right(true));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'FirebaseException'));
    }
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
    ConfirmPostEntity entity,
  ) async {
    try {
      final getResult = await _wehavitDatasource.deleteConfirmPost(entity);
      return Future(() => getResult);
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity entity) async {
    try {
      // update existing post
      entity = entity.copyWith(
        id: entity.id,
        owner: FirebaseAuth.instance.currentUser!.uid,
        createdAt: entity.createdAt,
        updatedAt: DateTime.now(),
      );

      _wehavitDatasource.updateConfirmPost(entity);

      return Future(() => right(true));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'FirebaseException'));
    }
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId({
    required String resolutionId,
  }) async {
    try {
      final getResult =
          await _wehavitDatasource.getConfirmPostEntityListByResolutionId(
        resolutionId,
      );

      return getResult.fold(
        (failure) => Future(() => left(failure)),
        (entityList) => Future(() => right(entityList)),
      );
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getGroupConfirmPostEntityListByDate({
    required String groupId,
    required DateTime selectedDate,
  }) async {
    try {
      final getResult =
          await _wehavitDatasource.getGroupConfirmPostEntityListByDate(
        groupId,
        selectedDate,
      );
      return getResult;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<String> uploadConfirmPostImage({
    required String localFileUrl,
  }) async {
    final uploadResult = await _wehavitDatasource
        .uploadConfirmPostImageFromLocalUrl(localFileUrl);
    return uploadResult;
  }
}
