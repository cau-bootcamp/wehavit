import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/friend_list/model/friend_list_view_model.dart';

class FriendListViewModelProvider extends StateNotifier<FriendListViewModel> {
  FriendListViewModelProvider(
    this._getFriendListUsecase,
    this._searchUserDataListByNicknameUsecase,
    this._getMyUserDataUsecase,
    this._getAppliedUserListForFriendUsecase,
    this._acceptApplyingForFriendUsecase,
    this._rejectApplyingForFriendUsecase,
    this._removeFriendUsecase,
    this._applyForUserFriendUsecase,
    this._getUserDataFromIdUsecase,
  ) : super(FriendListViewModel());

  final GetFriendListUsecase _getFriendListUsecase;
  final GetAppliedUserListForFriendUsecase _getAppliedUserListForFriendUsecase;
  final SearchUserDataListByNicknameUsecase
      _searchUserDataListByNicknameUsecase;
  final GetMyUserDataUsecase _getMyUserDataUsecase;
  final AcceptApplyingForFriendUsecase _acceptApplyingForFriendUsecase;
  final RejectApplyingForFriendUsecase _rejectApplyingForFriendUsecase;
  final RemoveFriendUsecase _removeFriendUsecase;
  final ApplyForUserFriendUsecase _applyForUserFriendUsecase;
  final GetUserDataFromIdUsecase _getUserDataFromIdUsecase;

  Future<void> getFriendList() async {
    state.futureFriendList = await _getFriendListUsecase().then(
      (result) => result.fold(
        (failure) => null,
        (list) => list,
      ),
    );
  }

  Future<void> searchUserByNickname({required String nickname}) async {
    state.futureSearchedUserList = await _searchUserDataListByNicknameUsecase(
      nickname: nickname,
    ).then(
      (result) => result.fold(
        (failure) => null,
        (list) => list,
      ),
    );
  }

  Future<void> getAppliedFriendList() async {
    state.futureAppliedUserList =
        await _getAppliedUserListForFriendUsecase().then(
      (result) => result.fold(
        (failure) => null,
        (list) => list,
      ),
    );
  }

  Future<void> getMyUserDataEntity() async {
    state.futureMyUserDataEntity = _getMyUserDataUsecase();
  }

  Future<void> rejectToBeFriendWith({required String targetUid}) async {
    _rejectApplyingForFriendUsecase(targetUid: targetUid);

    await removeTargetUserFrom(
      target: targetUid,
      from: state.futureAppliedUserList,
    );
  }

  Future<void> acceptToBeFriendWith({required String targetUid}) async {
    _acceptApplyingForFriendUsecase(targetUid: targetUid);

    await removeTargetUserFrom(
      target: targetUid,
      from: state.futureAppliedUserList,
    );

    state.futureFriendList?.add(_getUserDataFromIdUsecase(targetUid));
  }

  Future<void> removeTargetUserFrom({
    required String target,
    required List<EitherFuture<UserDataEntity>>? from,
  }) async {
    if (from == null) return;

    List<bool> shouldRemove = await Future.wait(
      from.map(
        (future) async {
          return future.then(
            (value) => value.fold(
              (failure) => false,
              (entity) => entity.userId == target,
            ),
          );
        },
      ),
    );

    for (int i = shouldRemove.length - 1; i >= 0; i--) {
      if (shouldRemove[i]) {
        from.removeAt(i);
      }
    }
  }

  Future<void> applyToBeFriendWith({required String targetUid}) async {
    await _applyForUserFriendUsecase(targetUserId: targetUid);
  }

  Future<void> removeFromFriendList({required String targetUid}) async {
    await _removeFriendUsecase(targetUid: targetUid);

    await removeTargetUserFrom(
      target: targetUid,
      from: state.futureFriendList,
    );

    print('remove');
  }
}
