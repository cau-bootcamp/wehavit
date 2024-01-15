import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

abstract class UserModelRepository {
  EitherFuture<UserDataEntity> fetchUserDataEntityFromId(String targetUserId);
}
