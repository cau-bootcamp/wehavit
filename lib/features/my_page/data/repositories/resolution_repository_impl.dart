import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource_provider.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(ProviderRef ref) {
    _resolutionDatasource = ref.watch(resolutionDatasourceProvider);
  }

  late final ResolutionDatasource _resolutionDatasource;

  @override
  Future<Either<Failure, List<ResolutionModel>>>
      getActiveResolutionModelList() {
    return _resolutionDatasource.getActiveResolutionModelList();
  }
}
