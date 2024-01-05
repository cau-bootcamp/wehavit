import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostModel>> getAllFanMarkedConfirmPosts();

  EitherFuture<bool> uploadConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> deleteConfirmPost(DocumentReference<ConfirmPostModel> ref);

  EitherFuture<bool> getConfirmPostByUserId(String userId);

  EitherFuture<ConfirmPostModel> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  );
}
