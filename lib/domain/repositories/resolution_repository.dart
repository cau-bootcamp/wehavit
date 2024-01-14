import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity model);
}
