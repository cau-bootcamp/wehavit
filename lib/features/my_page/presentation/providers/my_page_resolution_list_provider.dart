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
  MyPageResolutionListProvider(dynamic ref) : super(const Right([])) {
    print(getResolutionListUseCaseProvider);
    provider = ref.watch(getResolutionListUseCaseProvider);
    print("DEBUG : PROVIDER INIT");
    print(provider);
    // 이제 provider를 사용할 수 있습니다.
    // provider를 초기화하거나 필요한 작업을 수행하세요.
  }

  late final GetResolutionListUseCase provider;

  Future<void> getResolutionList() async {
    print("DEBUG : NO PROVIDER");
    print("${provider}");

    state = await provider.call(NoParams());
  }
}
