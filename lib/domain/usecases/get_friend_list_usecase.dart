import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetFriendListUsecase {
  GetFriendListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  EitherFuture<List<UserDataEntity>> call() async {
    return _friendRepository.getFriendEntityList();
  }
}
