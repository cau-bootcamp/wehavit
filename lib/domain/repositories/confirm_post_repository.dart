import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/wehavit_data_repository_impl.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';

abstract class ConfirmPostRepository {
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate({
    required int selectedDate,
  });

  EitherFuture<ConfirmPostEntity> getConfirmPostEntityByUserId({
    required String userId,
  });

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId({
    required String resolutionId,
  });

  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostEntity> confirmPostRef,
  );
}
