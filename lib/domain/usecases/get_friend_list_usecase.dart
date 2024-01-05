import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final getFriendListUseCaseProvider = Provider<GetFriendListUsecase>((ref) {
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  return GetFriendListUsecase(resolutionRepository);
});

class GetFriendListUsecase implements UseCase<List<FriendModel>?, NoParams> {
  GetFriendListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  Future<Either<Failure, List<FriendModel>>> call(NoParams params) async {
    return _friendRepository.getFriendModelList();
  }
}
