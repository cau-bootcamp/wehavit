import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

abstract class FriendRepository {
  EitherFuture<List<FriendModel>> getFriendModelList();
  EitherFuture<bool> uploadFriendModel(FriendModel model);
}
