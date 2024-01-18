import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

final confirmPostListProvider = StateNotifierProvider<ConfirmPostListProvider,
    Either<Failure, List<ConfirmPostEntity>>>((ref) {
  return ConfirmPostListProvider(ref);
});

class ConfirmPostListProvider
    extends StateNotifier<Either<Failure, List<ConfirmPostEntity>>> {
  ConfirmPostListProvider(Ref ref) : super(const Right([])) {
    getConfirmPostListUsecase = ref.watch(getConfirmPostListUsecaseProvider);
  }

  late final GetConfirmPostListUsecase getConfirmPostListUsecase;

  Future<void> getConfirmPostList(DateTime selectedDate) async {
    state = await getConfirmPostListUsecase(selectedDate);
  }
}
