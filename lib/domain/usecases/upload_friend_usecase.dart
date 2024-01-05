import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/add_friend_entity/add_friend_model.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final uploadFriendUsecaseProvider = Provider<UploadFriendUseCase>((ref) {
  final friendRepository = ref.watch(friendRepositoryProvider);
  return UploadFriendUseCase(friendRepository);
});

class UploadFriendUseCase implements UseCase<bool, AddFriendModel> {
  UploadFriendUseCase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(AddFriendModel newModel) async {
    return await _friendRepository.uploadFriendModel(newModel);
  }
}
