import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/data/entities/friend_entity.dart';

abstract class FriendDatasource {
  EitherFuture<List<FriendEntity>> getFriendEntityList();
  EitherFuture<bool> uploadFriendEntity(
      FriendEntity entity,
      );
}
