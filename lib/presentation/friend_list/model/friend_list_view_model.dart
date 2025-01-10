import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class FriendListViewModel {
  // EitherFuture<UserDataEntity>? futureMyUserDataEntity;

  List<EitherFuture<UserDataEntity>>? friendFutureUserList;

  List<EitherFuture<UserDataEntity>>? searchedFutureUserList;

  List<EitherFuture<UserDataEntity>>? appliedFutureUserList;
}
