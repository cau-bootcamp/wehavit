import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';

final uploadFriendUsecaseProvider = Provider<UploadFriendUseCase>((ref) {
  final friendRepository = ref.watch(friendRepositoryProvider);
  return UploadFriendUseCase(friendRepository);
});

class UploadFriendUseCase implements UseCase<bool, FriendModel> {
  UploadFriendUseCase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(FriendModel newModel) async {
    return await _friendRepository.uploadFriendModel(newModel);
  }
}
