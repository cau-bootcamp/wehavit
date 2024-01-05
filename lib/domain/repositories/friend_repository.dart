import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/add_friend_entity/add_friend_model.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/presentation/friend_list/data/repositories/friend_repository_impl.dart';

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  return FriendRepositoryImpl(ref);
});

abstract class FriendRepository {
  EitherFuture<List<FriendModel>> getFriendModelList();

  EitherFuture<bool> uploadFriendModel(AddFriendModel model);
}
