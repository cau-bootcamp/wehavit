import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/firebase_datasource_impl.dart';
import 'package:wehavit/data/models/user_model.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

final wehavitDatasourceProvider = Provider<WehavitDatasource>((ref) {
  return FirebaseDatasourceImpl();
});

abstract class WehavitDatasource {
  EitherFuture<List<UserModel>> getFriendModelList();

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

  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity);

  EitherFuture<UserDataEntity> fetchUserDataEntityByUserId(String targetUserId);
}
