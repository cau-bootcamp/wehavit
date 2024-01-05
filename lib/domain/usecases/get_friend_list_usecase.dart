import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/user_data_entity/friend_model.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final getFriendListUseCaseProvider = Provider<GetFriendListUsecase>((ref) {
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  return GetFriendListUsecase(resolutionRepository);
});

class GetFriendListUsecase implements UseCase<List<UserDataEntity>?, NoParams> {
  GetFriendListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  Future<Either<Failure, List<UserDataEntity>>> call(NoParams params) async {
    return _friendRepository.getFriendModelList();
  }
}
