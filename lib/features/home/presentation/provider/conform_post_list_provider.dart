import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/home/domain/usecases/get_confirm_post_list_usecase.dart';
import 'package:wehavit/features/home/domain/usecases/get_confirm_post_list_usecase_provider.dart';

final confirmPostListProvider = StateNotifierProvider<ConfirmPostListProvider,
    Either<Failure, List<ConfirmPostModel>>>((ref) {
  return ConfirmPostListProvider(ref);
});

class ConfirmPostListProvider
    extends StateNotifier<Either<Failure, List<ConfirmPostModel>>> {
  ConfirmPostListProvider(Ref ref) : super(const Right([])) {
    getConfirmPostListUsecase = ref.watch(getConfirmPostListUsecaseProvider);
  }

  late final GetConfirmPostListUsecase getConfirmPostListUsecase;

  Future<void> getConfirmPostList() async {
    state = await getConfirmPostListUsecase(NoParams());
  }
}
