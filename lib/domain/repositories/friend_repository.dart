import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/presentation/friend_list/data/repositories/friend_repository_impl.dart';

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  return FriendRepositoryImpl(ref);
});

abstract class FriendRepository {
  EitherFuture<List<UserDataEntity>> getFriendModelList();

  EitherFuture<bool> uploadFriendEntity(UserDataEntity model);
}
