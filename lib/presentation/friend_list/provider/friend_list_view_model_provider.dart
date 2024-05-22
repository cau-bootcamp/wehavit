import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/friend_list/model/friend_list_view_model.dart';

class FriendListViewModelProvider extends StateNotifier<FriendListViewModel> {
  FriendListViewModelProvider(
    this._getFriendListUsecase,
    this._searchUserDataListByNicknameUsecase,
    this._getMyUserDataUsecase,
    this._getAppliedUserListForFriendUsecase,
  ) : super(FriendListViewModel());

  final GetFriendListUsecase _getFriendListUsecase;
  final GetAppliedUserListForFriendUsecase _getAppliedUserListForFriendUsecase;
  final SearchUserDataListByNicknameUsecase
      _searchUserDataListByNicknameUsecase;
  final GetMyUserDataUsecase _getMyUserDataUsecase;

  void getFriendList() async {
    state.futureFriendList = _getFriendListUsecase();
  }

  Future<void> searchUserByNickname({required String nickname}) async {
    state.futureSearchedUserList = _searchUserDataListByNicknameUsecase(
      nickname: nickname,
    );
  }

  Future<void> getAppliedFriendList() async {
    state.futureAppliedUserList = _getAppliedUserListForFriendUsecase();
  }

  Future<void> getMyUserDataEntity() async {
    state.futureMyUserDataEntity = _getMyUserDataUsecase();
  }
}
