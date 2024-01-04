import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/domain/entities/resolution_model.dart';
import 'package:wehavit/presentation/my_page/data/repositories/resolution_repository_impl.dart';

final resolutionRepositoryProvider = Provider<ResolutionRepository>((ref) {
  return ResolutionRepositoryImpl(ref);
});

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionModel>> getActiveResolutionModelList();
  EitherFuture<bool> uploadResolutionModel(ResolutionModel model);
  EitherFuture<List<ConfirmPostModel>> getConfirmPostListForResolutionId({
    required String resolutionId,
  });
}
