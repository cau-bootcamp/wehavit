import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

class GetFriendUidListUsecase {
  GetFriendUidListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  EitherFuture<List<String>> call() async {
    return _friendRepository.getFriendUidList();
  }
}
