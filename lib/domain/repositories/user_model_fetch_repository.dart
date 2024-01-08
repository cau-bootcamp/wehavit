import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/legacy/swipe_view/data/repository/user_model_fetch_repository_impl.dart';

final userDataFetchRepositoryProvider =
    Provider<UserModelFetchRepository>((ref) {
  return UserModelFetchRepositoryImpl(ref);
});

abstract class UserModelFetchRepository {
  EitherFuture<UserDataEntity> fetchUserModelFromId(String targetUserId);
}
