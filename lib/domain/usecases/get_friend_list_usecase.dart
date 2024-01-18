import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/friend_repository_impl.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final getFriendListUseCaseProvider = Provider<GetFriendListUsecase>((ref) {
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  return GetFriendListUsecase(resolutionRepository);
});

class GetFriendListUsecase
    implements FutureUseCase<List<UserDataEntity>?, NoParams> {
  GetFriendListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  Future<Either<Failure, List<UserDataEntity>>> call(NoParams params) async {
    return _friendRepository.getFriendEntityList();
  }
}
