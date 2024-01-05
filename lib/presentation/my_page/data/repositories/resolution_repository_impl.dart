import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';
import 'package:wehavit/presentation/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/presentation/my_page/data/datasources/resolution_datasource_provider.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(Ref ref) {
    _resolutionDatasource = ref.watch(resolutionDatasourceProvider);
  }

  late final ResolutionDatasource _resolutionDatasource;

  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionModelList() async {
    try {
      final getResult =
          await _resolutionDatasource.getActiveResolutionEntityList();

      return getResult.fold((failure) => left(failure), (entityList) {
        final modelList =
            entityList.map((entity) => entity.toResolutionEntity()).toList();

        return Future(() => right(modelList));
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> uploadResolutionModel(
    ResolutionEntity entity,
  ) async {
    return _resolutionDatasource.uploadResolutionEntity(entity);
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostListForResolutionId({
    required String resolutionId,
  }) {
    return _resolutionDatasource.getConfirmPostListForResolutionId(
      resolutionId: resolutionId,
    );
  }
}
