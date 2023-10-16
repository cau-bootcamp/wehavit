import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/usecases/get_resolution_list_usecase.dart';
import 'package:wehavit/features/my_page/domain/usecases/get_resolution_list_usecase_provider.dart';

final myPageResolutionListProvider = StateNotifierProvider<
    MyPageResolutionListProvider,
    Either<Failure, List<ResolutionModel>>>((ref) {
  return MyPageResolutionListProvider(ref);
});

class MyPageResolutionListProvider
    extends StateNotifier<Either<Failure, List<ResolutionModel>>> {
  MyPageResolutionListProvider(Ref ref) : super(const Right([])) {
    provider = ref.watch(getResolutionListUseCaseProvider);
  }

  late final GetResolutionListUseCase provider;

  Future<void> getActiveResolutionList() async {
    state = await provider.call(NoParams());
  }
}
