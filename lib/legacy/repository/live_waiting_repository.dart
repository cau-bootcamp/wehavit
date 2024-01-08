import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/legacy/waiting_user_entity/waiting_user_model.dart';

abstract class LiveWaitingRepository {
  Future<bool> syncLiveWaitingUserStatus(DateTime nowTime);

  Future<Stream<List<WaitingUser>>> getLiveWaitingUsersStream({
    List<UserDataEntity> friendList = const [],
  });
}
