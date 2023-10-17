import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/data/entities/new_resolution_entity.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

abstract class ResolutionDatasource {
  Future<Either<Failure, List<ResolutionModel>>> getActiveResolutionModelList();
  Future<Either<Failure, List<ResolutionModel>>> getAllResolutionModelList();
  Future<Either<Failure, bool>> uploadResolutionEntity(
    ResolutionToUploadEntity entity,
  );
}
