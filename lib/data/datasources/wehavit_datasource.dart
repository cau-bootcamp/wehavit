import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class WehavitDatasource {
  EitherFuture<List<UserDataEntity>> getFriendModelList();

  EitherFuture<bool> registerFriend(
    String email,
  );

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate(
    DateTime selectedDate,
  );

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
    String resolutionId,
  );

  EitherFuture<ConfirmPostEntity> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  );

  EitherFuture<bool> uploadConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionEntity,
  );

  EitherFuture<List<ReactionEntity>> getUnreadReactions();
  EitherFuture<List<ReactionEntity>> getReactionsFromConfirmPost(
    ConfirmPostEntity entity,
  );

  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity);

  EitherFuture<UserDataEntity> fetchUserDataEntityByUserId(String targetUserId);

  EitherFuture<String> getMyUserId();

  EitherFuture<String> uploadQuickShotFromLocalUrlToConfirmPost({
    required String localPhotoUrl,
    required ConfirmPostEntity entity,
  });

  EitherFuture<String> uploadConfirmPostImageFromLocalUrl(String localFileUrl);
}
