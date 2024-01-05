import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';
import 'package:wehavit/domain/usecases/upload_friend_usecase.dart';

final addFriendProvider =
    StateNotifierProvider.autoDispose<AddFriendNotifier, FriendModel>((ref) {
  return AddFriendNotifier(ref);
});

class AddFriendNotifier extends StateNotifier<FriendModel> {
  AddFriendNotifier(Ref ref) : super(FriendModel()) {
    _uploadFriendUsecase = ref.watch(uploadFriendUsecaseProvider);
  }

  late final UploadFriendUseCase _uploadFriendUsecase;

  void setFriendEmail(String friendEmail) {
    state = state.copyWith(friendEmail: friendEmail);
    //print('add_friend_provider : ${state.friendEmail}');
  }

  EitherFuture<bool> uploadFriendModel() {
    //print('watch state.friendEmail : ${state.friendEmail}');
    FriendModel newModel = FriendModel(
      friendEmail: state.friendEmail,
    );
    return _uploadFriendUsecase(newModel);
  }
}
