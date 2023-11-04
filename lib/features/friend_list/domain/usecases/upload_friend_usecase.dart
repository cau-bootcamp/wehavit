import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository.dart';

class UploadFriendUseCase implements UseCase<bool, AddFriendModel> {
  UploadFriendUseCase(this._friendRepository);

  final FriendRepository _friendRepository;

  @override
  EitherFuture<bool> call(AddFriendModel newModel) async {
    return await _friendRepository.uploadFriendModel(newModel);
  }
}
