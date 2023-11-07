import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';

abstract class UserModelFetchRepository {
  EitherFuture<UserModel> fetchUserModelFromId(String targetUserId);
}
