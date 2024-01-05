import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';

abstract class ResolutionDatasource {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList();
  EitherFuture<List<ResolutionEntity>> getAllResolutionEntityList();
  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity);
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostListForResolutionId({
    required String resolutionId,
  });
}
