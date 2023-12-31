import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';
import 'package:wehavit/presentation/home/data/datasources/confirm_post_datasource.dart';
import 'package:wehavit/presentation/home/data/datasources/confirm_post_datasource_provider.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(Ref ref) {
    _confirmPostDatasource = ref.watch(confirmPostDatasourceProvider);
  }

  late final ConfirmPostDatasource _confirmPostDatasource;

  @override
  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost) {
    // TODO: implement createConfirmPost
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
      DocumentReference<ConfirmPostEntity> confirmPostRef) {
    // TODO: implement deleteConfirmPost
    throw UnimplementedError();
  }

  @override
  EitherFuture<ConfirmPostEntity> getConfirmPostEntityByUserId({
    required String userId,
  }) {
    // TODO: implement getConfirmPostByUserId
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost) {
    // TODO: implement updateConfirmPost
    throw UnimplementedError();
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
      {required String resolutionId}) {
    // TODO: implement getConfirmPostListForResolutionId
    throw UnimplementedError();
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate(
      {required int selectedDate}) async {
    try {
      final getResult = await _confirmPostDatasource.getConfirmPostEntityList(
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
