import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/usecases/get_my_resolution_list_usecase.dart';

final activeResolutionListProvider =
    FutureProvider.autoDispose<Either<Failure, List<ResolutionEntity>>>(
        (ref) async {
  final getResolutionListUsecase =
      ref.watch(getMyResolutionListUsecaseProvider);
  return await getResolutionListUsecase(NoParams());
});
