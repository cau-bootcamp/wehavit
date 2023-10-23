import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource_provider.dart';
import 'package:wehavit/features/my_page/data/entities/resolution_entity.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(Ref ref) {
    _resolutionDatasource = ref.watch(resolutionDatasourceProvider);
  }

  late final ResolutionDatasource _resolutionDatasource;

  @override
  EitherFuture<List<ResolutionModel>> getActiveResolutionModelList() async {
    try {
      final getResult =
          await _resolutionDatasource.getActiveResolutionEntityList();

      return getResult.fold((failure) => left(failure), (entityList) {
        final modelList =
            entityList.map((entity) => entity.toResolutionModel()).toList();

        return Future(() => right(modelList));
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> uploadResolutionModel(
    ResolutionModel model,
  ) async {
    final entity = ResolutionEntity.fromResolutionModel(model);
    return _resolutionDatasource.uploadResolutionEntity(entity);
  }
}
