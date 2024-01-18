import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ConfirmPostRepositoryImpl(wehavitDatasource);
});

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
          confirmPostEntity = confirmPostEntity.copyWith(
            owner: FirebaseAuth.instance.currentUser!.uid,
          );

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
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate({
    required DateTime selectedDate,
  }) async {
    try {
      final getResult = await _wehavitDatasource.getConfirmPostEntityListByDate(
        selectedDate,
      );
      return getResult;
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
