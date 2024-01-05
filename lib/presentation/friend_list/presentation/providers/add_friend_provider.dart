import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/usecases/upload_friend_usecase.dart';

final addFriendProvider =
    StateNotifierProvider.autoDispose<AddFriendNotifier, UserDataEntity>((ref) {
  return AddFriendNotifier(ref);
});

class AddFriendNotifier extends StateNotifier<UserDataEntity> {
  AddFriendNotifier(Ref ref) : super(UserDataEntity()) {
    _uploadFriendUsecase = ref.watch(uploadFriendUsecaseProvider);
  }

  late final UploadFriendUseCase _uploadFriendUsecase;

  void setFriendEmail(String friendEmail) {
    state = state.copyWith(friendEmail: friendEmail);
    //print('add_friend_provider : ${state.friendEmail}');
  }

  EitherFuture<bool> uploadFriendModel() {
    //print('watch state.friendEmail : ${state.friendEmail}');
    UserDataEntity newModel = UserDataEntity(
      friendEmail: state.friendEmail,
    );
    return _uploadFriendUsecase(newModel);
  }
}
