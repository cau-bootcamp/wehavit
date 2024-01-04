import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/presentation/swipe_view/data/repository/user_model_fetch_repository_impl.dart';

final userModelFetchRepositoryProvider =
    Provider<UserModelFetchRepository>((ref) {
  return UserModelFetchRepositoryImpl(ref);
});

abstract class UserModelFetchRepository {
  EitherFuture<UserModel> fetchUserModelFromId(String targetUserId);
}
