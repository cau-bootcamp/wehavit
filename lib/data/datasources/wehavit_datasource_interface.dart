import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

abstract class WehavitDatasource {
  // Friend Repository
  EitherFuture<List<UserDataEntity>> getFriendEntityList();

  EitherFuture<bool> uploadFriendEntity(
    UserDataEntity entity,
  );

  // Confirm Post Repository
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList(
    int selectedDate,
  );

  EitherFuture<ConfirmPostEntity> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  );

  EitherFuture<bool> uploadConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionEntity,
  );

  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList();

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity);

  EitherFuture<UserDataEntity> fetchUserDataEntityFromId(String targetUserId);
}
