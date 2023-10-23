import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
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
    getResolutionListUsecase = ref.watch(getResolutionListUseCaseProvider);
  }

  late final GetResolutionListUsecase getResolutionListUsecase;

  Future<void> getActiveResolutionList() async {
    state = await getResolutionListUsecase.call(NoParams());
    state.fold((l) {
      print("WRONG");
    }, (r) {
      Future.delayed(Duration(seconds: 2));
      print(r.length);
    });
  }
}
