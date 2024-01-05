import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/presentation/home/data/repositories/confirm_post_repository_impl.dart';

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  return ConfirmPostRepositoryImpl(ref);
});

abstract class ConfirmPostRepository {
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostModelList(
    int selectedIndex,
  );

  EitherFuture<ConfirmPostEntity> getConfirmPostByUserId(String userId);

  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostEntity> confirmPostRef,
  );
}
