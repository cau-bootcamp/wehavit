import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/add_friend_model.dart';
import 'package:wehavit/domain/usecases/upload_friend_usecase.dart';

final addFriendProvider =
    StateNotifierProvider.autoDispose<AddFriendNotifier, AddFriendModel>((ref) {
  return AddFriendNotifier(ref);
});

class AddFriendNotifier extends StateNotifier<AddFriendModel> {
  AddFriendNotifier(Ref ref) : super(AddFriendModel()) {
    _uploadFriendUsecase = ref.watch(uploadFriendUsecaseProvider);
  }

  late final UploadFriendUseCase _uploadFriendUsecase;

  void setFriendEmail(String friendEmail) {
    state = state.copyWith(friendEmail: friendEmail);
    //print('add_friend_provider : ${state.friendEmail}');
  }

  EitherFuture<bool> uploadFriendModel() {
    //print('watch state.friendEmail : ${state.friendEmail}');
    AddFriendModel newModel = AddFriendModel(
      friendEmail: state.friendEmail,
    );
    return _uploadFriendUsecase(newModel);
  }
}
