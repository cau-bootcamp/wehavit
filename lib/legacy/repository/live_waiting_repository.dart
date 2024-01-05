import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/legacy/waiting_user_entity/waiting_user_model.dart';

abstract class LiveWaitingRepository {
  Future<bool> syncLiveWaitingUserStatus(DateTime nowTime);

  Future<Stream<List<WaitingUser>>> getLiveWaitingUsersStream({
    List<FriendModel> friendList = const [],
  });
}
