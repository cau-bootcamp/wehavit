import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class ConfirmPostRepository {
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate({
    required DateTime selectedDate,
    required List<String> resolutionList,
  });

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityByDate({
    required DateTime selectedDate,
    required String targetResolutionId,
  });

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId({
    required String resolutionId,
  });

  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(
    ConfirmPostEntity confirmPost,
  );

  EitherFuture<String> uploadConfirmPostImage({required String localFileUrl});

  EitherFuture<List<ConfirmPostEntity>> getFriendConfirmPostEntityListByDate({
    required List<String> targetResolutionList,
    required DateTime selectedDate,
  });
}
