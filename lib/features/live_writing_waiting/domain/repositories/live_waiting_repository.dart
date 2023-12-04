import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';

abstract class LiveWaitingRepository {
  Future<bool> syncLiveWaitingUserStatus(DateTime nowTime);

  Stream<List<WaitingUser>> getLiveWaitingUsersStream();
}
