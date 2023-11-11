import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/data/entities/add_friend_entity.dart';
import 'package:wehavit/features/friend_list/data/entities/friend_entity.dart';

abstract class FriendDatasource {
  EitherFuture<List<FriendEntity>> getFriendEntityList();

  EitherFuture<bool> uploadAddFriendEntity(
    AddFriendEntity entity,
  );
}
