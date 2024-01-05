import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/presentation/my_page/data/repositories/resolution_repository_impl.dart';

final resolutionRepositoryProvider = Provider<ResolutionRepository>((ref) {
  return ResolutionRepositoryImpl(ref);
});

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionModelList();
  EitherFuture<bool> uploadResolutionModel(ResolutionEntity model);
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostListForResolutionId({
    required String resolutionId,
  });
}
