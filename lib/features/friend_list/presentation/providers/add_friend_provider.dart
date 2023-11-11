import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/domain/models/add_friend_model.dart';
import 'package:wehavit/features/friend_list/domain/usecases/upload_friend_usecase.dart';
import 'package:wehavit/features/friend_list/domain/usecases/upload_friend_usecase_provider.dart';

final addFriendProvider =
    StateNotifierProvider.autoDispose<AddFriendNotifier, AddFriendModel>((ref) {
  return AddFriendNotifier(ref);
});

class AddFriendNotifier extends StateNotifier<AddFriendModel> {
  AddFriendNotifier(Ref ref) : super(AddFriendModel()) {
    _uploadFriendUsecase = ref.watch(uploadFriendUsecaseProvider);
  }

  late final UploadFriendUseCase _uploadFriendUsecase;

  void setFriendID(String friendID) {
    state = state.copyWith(friendID: friendID);
    //print('add_friend_provider : ${state.friendID}');
  }

  EitherFuture<bool> uploadFriendModel() {
    //print('watch state.friendID : ${state.friendID}');
    AddFriendModel newModel = AddFriendModel(
      friendID: state.friendID,
    );
    return _uploadFriendUsecase.call(newModel);
  }
}
