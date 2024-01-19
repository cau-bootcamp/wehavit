import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetFriendListUsecase
    implements FutureUseCase<List<UserDataEntity>?, NoParams> {
  GetFriendListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<List<UserDataEntity>> call(NoParams params) async {
    return _friendRepository.getFriendEntityList();
  }
}
