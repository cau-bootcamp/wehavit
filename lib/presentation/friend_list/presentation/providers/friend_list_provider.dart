import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/friend_model.dart';
import 'package:wehavit/domain/usecases/get_friend_list_usecase.dart';

final friendListProvider = StateNotifierProvider<FriendListProvider,
    Either<Failure, List<FriendModel>>>((ref) {
  return FriendListProvider(ref);
});

class FriendListProvider
    extends StateNotifier<Either<Failure, List<FriendModel>>> {
  FriendListProvider(Ref ref) : super(const Right([])) {
    getFriendListUsecase = ref.watch(getFriendListUseCaseProvider);
  }

  late final GetFriendListUsecase getFriendListUsecase;

  Future<void> getFriendList() async {
    state = await getFriendListUsecase(NoParams());
  }
}
