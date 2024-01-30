import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/entities/group_announcement_entity/group_announcement_entity.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity model);

  EitherFuture<void> shareResolutionToGroup(String $1, String $2);

  EitherFuture<void> unshareResolutionToGroup(String $1, String $2);

  EitherFuture<void> uploadGroupAnnouncementEntity(
    GroupAnnouncementEntity entity,
  );
}
