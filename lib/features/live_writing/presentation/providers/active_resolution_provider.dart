import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/usecases/get_resolution_list_usecase_provider.dart';

final activeResolutionListProvider =
    FutureProvider<Either<Failure, List<ResolutionModel>>>((ref) async {
  var getResolutionListUsecase = ref.watch(getResolutionListUseCaseProvider);
  return await getResolutionListUsecase.call(NoParams());
});
