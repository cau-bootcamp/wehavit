import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/wehavit_data_repository_impl.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionModelList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity model);
}
