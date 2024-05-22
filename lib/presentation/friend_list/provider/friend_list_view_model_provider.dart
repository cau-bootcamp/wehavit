import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/friend_list/model/friend_list_view_model.dart';

class FriendListViewModelProvider extends StateNotifier<FriendListViewModel> {
  FriendListViewModelProvider(
    this._getFriendListUsecase,
    this._searchUserDataListByNicknameUsecase,
  ) : super(FriendListViewModel());

  final GetFriendListUsecase _getFriendListUsecase;
  final SearchUserDataListByNicknameUsecase
      _searchUserDataListByNicknameUsecase;

  void getFriendList() async {
    state.futureFriendList = _getFriendListUsecase();
  }

  Future<void> searchUserByNickname({required String nickname}) async {
    print("n: $nickname");
    state.searchedUserList = _searchUserDataListByNicknameUsecase(
      nickname: nickname,
    );
  }
}
