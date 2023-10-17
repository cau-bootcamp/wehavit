import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource_provider.dart';
import 'package:wehavit/features/my_page/data/entities/new_resolution_entity.dart';
import 'package:wehavit/features/my_page/domain/models/add_resolution_model.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(Ref ref) {
    _resolutionDatasource = ref.watch(resolutionDatasourceProvider);
  }

  late final ResolutionDatasource _resolutionDatasource;

  @override
  Future<Either<Failure, List<ResolutionModel>>>
      getActiveResolutionModelList() async {
    return await _resolutionDatasource.getActiveResolutionModelList();
  }

  @override
  Future<Either<Failure, bool>> uploadResolutionModel(
    AddResolutionModel model,
  ) async {
    final entity = ResolutionToUploadEntity(model);
    return _resolutionDatasource.uploadResolutionEntity(entity);
  }
}
