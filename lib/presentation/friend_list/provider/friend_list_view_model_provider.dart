import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/friend_list/model/friend_list_view_model.dart';

class FriendListViewModelProvider extends StateNotifier<FriendListViewModel> {
  FriendListViewModelProvider(
    this._getFriendListUsecase,
    this._searchUserDataListByHandleUsecase,
    this._getAppliedUserListForFriendUsecase,
    this._acceptApplyingForFriendUsecase,
    this._rejectApplyingForFriendUsecase,
    this._removeFriendUsecase,
    this._applyForUserFriendUsecase,
    this._getUserDataFromIdUsecase,
  ) : super(FriendListViewModel());

  final GetFriendListUsecase _getFriendListUsecase;
  final GetAppliedUserUidListForFriendUsecase _getAppliedUserListForFriendUsecase;
  final SearchUserByHandleUsecase _searchUserDataListByHandleUsecase;
  final AcceptApplyingForFriendUsecase _acceptApplyingForFriendUsecase;
  final RejectApplyingForFriendUsecase _rejectApplyingForFriendUsecase;
  final RemoveFriendUsecase _removeFriendUsecase;
  final ApplyForUserFriendUsecase _applyForUserFriendUsecase;
  final GetUserDataFromIdUsecase _getUserDataFromIdUsecase;

  Future<void> getFriendList() async {
    state.friendFutureUserList = _getFriendListUsecase().then((result) => result);
  }

  // Future<void> searchUserByHandle({required String handle}) async {
  //   state.searchedFutureUserList = await _searchUserDataListByHandleUsecase(
  //     handle: handle,
  //   ).then(
  //     (result) => result.fold(
  //       (failure) => null,
  //       (list) => list,
  //     ),
  //   );
  // }

  // Future<void> getAppliedFriendList() async {
  //   state.appliedFutureUserList = await _getAppliedUserListForFriendUsecase().then(
  //     (result) => result.fold(
  //       (failure) => null,
  //       (list) => list,
  //     ),
  //   );
  // }

  Future<void> rejectToBeFriendWith({required String targetUid}) async {
    _rejectApplyingForFriendUsecase(targetUid: targetUid);

    await removeTargetUserFrom(
      target: targetUid,
      from: state.appliedFutureUserList,
    );
  }

  Future<void> acceptToBeFriendWith({required String targetUid}) async {
    _acceptApplyingForFriendUsecase(targetUid: targetUid);

    await removeTargetUserFrom(
      target: targetUid,
      from: state.appliedFutureUserList,
    );

// TODO: 친구 추가 후 상태 업데이트 로직 추가
    // _getUserDataFromIdUsecase.call(targetUid).then((result) => result.fold((failure) {}, (success) {
    //       state.friendFutureUserList.add(success);
    //     }));
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

  EitherFuture<void> applyToBeFriendWith({required String targetUid}) async {
    return await _applyForUserFriendUsecase(targetUserId: targetUid);
  }

  Future<void> removeFromFriendList({required String targetUid}) async {
    await _removeFriendUsecase(targetUid: targetUid);

    // TODO: 친구 삭제 후 상태 업데이트 로직 추가

    // await removeTargetUserFrom(
    //   target: targetUid,
    //   from: state.friendFutureUserList,
    // );
  }

  void resetFriendSearchData() {
    state.searchedFutureUserList = null;
  }
}
