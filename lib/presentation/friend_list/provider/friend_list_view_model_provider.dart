import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/friend_list/model/friend_list_view_model.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';
import 'package:wehavit/presentation/state/friend/friend_manage_list_provider.dart';

class FriendListViewModelProvider extends StateNotifier<FriendListViewModel> {
  FriendListViewModelProvider(
    this.ref,
    this._acceptApplyingForFriendUsecase,
    this._rejectApplyingForFriendUsecase,
    this._removeFriendUsecase,
    this._applyForUserFriendUsecase,
  ) : super(FriendListViewModel());

  final Ref ref;
  final AcceptApplyingForFriendUsecase _acceptApplyingForFriendUsecase;
  final RejectApplyingForFriendUsecase _rejectApplyingForFriendUsecase;
  final RemoveFriendUsecase _removeFriendUsecase;
  final ApplyForUserFriendUsecase _applyForUserFriendUsecase;

  Future<void> removeFriend({required String targetUid}) async {
    await _removeFriendUsecase(targetUid: targetUid).then(
      (result) => result.fold(
        (failure) {},
        (success) {
          ref.invalidate(friendUidListProvider);
        },
      ),
    );
  }

  Future<void> applyToBeFrendWith({required String targetUid}) async {
    await _applyForUserFriendUsecase(targetUserId: targetUid).then(
      (result) => result.fold(
        (failure) {},
        (success) {},
      ),
    );
  }

  Future<void> refuseToBeFriendWith({required String targetUid}) async {
    await _rejectApplyingForFriendUsecase(targetUid: targetUid).then(
      (result) => result.fold(
        (failure) {},
        (success) {
          ref.invalidate(appliedUserUidListProvider);
          ref.invalidate(friendUidListProvider);
        },
      ),
    );
  }

  Future<void> acceptToBeFriendWith({required String targetUid}) async {
    await _acceptApplyingForFriendUsecase(targetUid: targetUid).then(
      (result) => result.fold(
        (failure) {},
        (success) {
          ref.invalidate(appliedUserUidListProvider);
          ref.invalidate(friendUidListProvider);
        },
      ),
    );
  }
}
