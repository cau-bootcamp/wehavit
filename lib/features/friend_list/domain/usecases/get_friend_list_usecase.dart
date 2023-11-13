import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository.dart';

class GetFriendListUsecase implements UseCase<List<FriendModel>?, NoParams> {
  GetFriendListUsecase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  Future<Either<Failure, List<FriendModel>>> call(NoParams params) async {
    return _friendRepository.getFriendModelList();
  }
}
