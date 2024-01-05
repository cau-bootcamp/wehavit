import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final uploadFriendUsecaseProvider = Provider<UploadFriendUseCase>((ref) {
  final friendRepository = ref.watch(friendRepositoryProvider);
  return UploadFriendUseCase(friendRepository);
});

class UploadFriendUseCase implements FutureUseCase<bool, UserDataEntity> {
  UploadFriendUseCase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(UserDataEntity newModel) async {
    return await _friendRepository.uploadFriendModel(newModel);
  }
}
