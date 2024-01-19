import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

class FriendListProvider
    extends StateNotifier<Either<Failure, List<UserDataEntity>>> {
  FriendListProvider(Ref ref) : super(const Right([])) {
    getFriendListUsecase = ref.watch(getFriendListUseCaseProvider);
  }

  late final GetFriendListUsecase getFriendListUsecase;

  Future<void> getFriendList() async {
    state = await getFriendListUsecase(NoParams());
  }
}
