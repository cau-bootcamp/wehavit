import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/presentation/my_page/data/entities/resolution_entity.dart';

abstract class ResolutionDatasource {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList();
  EitherFuture<List<ResolutionEntity>> getAllResolutionEntityList();
  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity);
  EitherFuture<List<ConfirmPostModel>> getConfirmPostListForResolutionId({
    required String resolutionId,
  });
}
