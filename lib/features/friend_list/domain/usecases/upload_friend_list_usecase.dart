import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository.dart';

class UploadFriendUseCase implements UseCase<bool, FriendModel> {
  UploadFriendUseCase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(FriendModel newModel) async {
    return await _friendRepository.uploadFriendModel(newModel);
  }
}
