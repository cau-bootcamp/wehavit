import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts();

  EitherFuture<bool> createConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostModel confirmPost);

  EitherFuture<bool> deleteConfirmPost(DocumentReference<ConfirmPostModel> ref);

  EitherFuture<bool> getConfirmPostByUserId(String userId);
}
