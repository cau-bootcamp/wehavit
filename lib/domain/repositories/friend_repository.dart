import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/wehavit_data_repository_impl.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  return ref.watch(wehavitDataRepositoryProvider);
});

abstract class FriendRepository {
  EitherFuture<List<UserDataEntity>> getFriendModelList();

  EitherFuture<bool> uploadFriendEntity(UserDataEntity model);
}
