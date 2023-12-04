import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';

abstract class LiveWaitingRepository {
  EitherFuture<bool> syncLiveWaitingUserStatus(WaitingUser user);

  EitherFuture<Stream<List<WaitingUser>>> getLiveWaitingUsersStream();
}
