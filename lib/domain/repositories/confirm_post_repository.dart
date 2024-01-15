import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';

abstract class ConfirmPostRepository {
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate({
    required DateTime selectedDate,
  });

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId({
    required String resolutionId,
  });

  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(
    ConfirmPostEntity confirmPost,
  );
}
