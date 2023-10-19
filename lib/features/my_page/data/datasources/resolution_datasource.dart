import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/my_page/data/entities/new_resolution_entity.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

abstract class ResolutionDatasource {
  EitherFuture<List<ResolutionModel>> getActiveResolutionModelList();
  EitherFuture<List<ResolutionModel>> getAllResolutionModelList();
  EitherFuture<bool> uploadResolutionEntity(
    ResolutionToUploadEntity entity,
  );
}
