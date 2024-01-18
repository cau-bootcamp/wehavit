import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

final addFriendProvider =
    StateNotifierProvider.autoDispose<AddFriendNotifier, String>((ref) {
  return AddFriendNotifier(ref);
});

class AddFriendNotifier extends StateNotifier<String> {
  AddFriendNotifier(Ref ref) : super('') {
    _registerFriendUsecase = ref.watch(registerFriendUsecaseProvider);
  }

  late final RegisterFriendUsecase _registerFriendUsecase;

  void setFriendEmail(String friendEmail) {
    state = friendEmail;
    //print('add_friend_provider : ${state.friendEmail}');
  }

  EitherFuture<bool> uploadFriendModel() {
    //print('watch state.friendEmail : ${state.friendEmail}');
    // UserDataEntity newModel = UserDataEntity(
    //   userEmail: state.userEmail,
    // );
    return _registerFriendUsecase(state);
  }
}
