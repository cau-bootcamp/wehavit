import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;
  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  ) async {
    try {
      final getResult =
          await _wehavitDatasource.getActiveResolutionEntityList(userId);

      return getResult.fold(
        (failure) => left(failure),
        (entityList) async {
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
