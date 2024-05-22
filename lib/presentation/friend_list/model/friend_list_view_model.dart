import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class FriendListViewModel {
  EitherFuture<List<EitherFuture<UserDataEntity>>>? futureFriendList;

  EitherFuture<List<EitherFuture<UserDataEntity>>>? searchedUserList;

  EitherFuture<List<EitherFuture<UserDataEntity>>>? appliedUserList;
}
