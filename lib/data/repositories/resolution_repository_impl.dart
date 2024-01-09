import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final resolutionRepositoryProvider = Provider<ResolutionRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ResolutionRepositoryImpl(wehavitDatasource);
});

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;
  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionModelList(
    String userId,
  ) async {
    try {
      final getResult =
          await _wehavitDatasource.getActiveResolutionEntityList();

      return getResult.fold(
        (failure) => left(failure),
        (entityList) {
          // final modelList =
          // entityList.map((entity) => entity.toResolutionEntity()).toList();

          return Future(() => right(entityList));
        },
      );
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> uploadResolutionEntity(
    ResolutionEntity entity,
  ) async {
    return _wehavitDatasource.uploadResolutionEntity(entity);
  }
}
