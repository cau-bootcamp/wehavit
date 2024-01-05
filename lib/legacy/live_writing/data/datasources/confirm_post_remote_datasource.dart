import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostEntity>> getAllFanMarkedConfirmPosts();

  EitherFuture<bool> uploadConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(
      DocumentReference<ConfirmPostEntity> ref);

  EitherFuture<bool> getConfirmPostByUserId(String userId);

  EitherFuture<ConfirmPostEntity> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  );
}
