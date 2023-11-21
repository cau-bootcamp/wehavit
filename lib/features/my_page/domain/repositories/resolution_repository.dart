import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionModel>> getActiveResolutionModelList();
  EitherFuture<bool> uploadResolutionModel(ResolutionModel model);
  EitherFuture<List<ConfirmPostModel>> getConfirmPostListForResolutionId({
    required String resolutionId,
  });
}
