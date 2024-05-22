import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class FriendListViewModel {
  EitherFuture<UserDataEntity>? futureMyUserDataEntity;

  EitherFuture<List<EitherFuture<UserDataEntity>>>? futureFriendList;

  EitherFuture<List<EitherFuture<UserDataEntity>>>? futureSearchedUserList;

  EitherFuture<List<EitherFuture<UserDataEntity>>>? futureAppliedUserList;
}
