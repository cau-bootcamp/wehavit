import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class FriendRepository {
  EitherFuture<List<EitherFuture<UserDataEntity>>> getFriendEntityList();

  EitherFuture<bool> registerFriend(String email);
}
