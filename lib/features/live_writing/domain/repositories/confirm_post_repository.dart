import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/models.dart';

abstract class ConfirmPostRepository {
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts();

  EitherFuture<ConfirmPostModel> getConfirmPostByUserId(String userId);

  EitherFuture<bool> createConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostModel> confirmPostRef,
  );
}
