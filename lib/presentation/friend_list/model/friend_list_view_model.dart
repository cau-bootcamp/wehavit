import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class FriendListViewModel {
  EitherFuture<UserDataEntity>? futureMyUserDataEntity;

  List<EitherFuture<UserDataEntity>>? futureFriendList;

  List<EitherFuture<UserDataEntity>>? futureSearchedUserList;

  List<EitherFuture<UserDataEntity>>? futureAppliedUserList;
}
