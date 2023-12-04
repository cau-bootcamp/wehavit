import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';

abstract class LiveWaitingRepository {
  Future<bool> syncLiveWaitingUserStatus(DateTime nowTime);

  Future<Stream<List<WaitingUser>>> getLiveWaitingUsersStream({
    List<FriendModel> friendList = const [],
  });
}
