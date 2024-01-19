import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

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
