import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/presentation.dart';

class AddResolutionDoneViewModelProvider
    extends StateNotifier<AddResolutionDoneViewModel> {
  AddResolutionDoneViewModelProvider(
    this.getFriendListUsecase,
    this.getGroupListUsecase,
    this.getGroupListViewCellWidgetModelUsecase,
    this.shareResolutionToFriendUsecase,
    this.unshareResolutionToFriendUsecase,
    this.shareResolutionToGroupUsecase,
    this.unshareResolutionToGroupUsecase,
  ) : super(AddResolutionDoneViewModel());

  GetFriendListUsecase getFriendListUsecase;
  GetGroupListUsecase getGroupListUsecase;
  GetGroupListViewCellWidgetModelUsecase getGroupListViewCellWidgetModelUsecase;
  ShareResolutionToFriendUsecase shareResolutionToFriendUsecase;
  UnshareResolutionToFriendUsecase unshareResolutionToFriendUsecase;
  ShareResolutionToGroupUsecase shareResolutionToGroupUsecase;
  UnshareResolutionToGroupUsecase unshareResolutionToGroupUsecase;

  void toggleFriendSelection(index) {
    if (state.tempSelectedFriendList != null) {
      state.tempSelectedFriendList![index] =
          !state.tempSelectedFriendList![index];
    }
  }

  void toggleGroupSelection(index) {
    if (state.tempSelectedGroupList != null) {
      state.tempSelectedGroupList![index] =
          !state.tempSelectedGroupList![index];
    }
  }

  Future<void> loadFriendList() async {
    state.friendList = await getFriendListUsecase.call().then(
          (result) => result.fold(
            (failure) => null,
            (list) => list,
          ),
        );

    final sharedFriendList = state.resolutionEntity?.shareFriendEntityList
        ?.map((entity) => entity.userId)
        .toList();
    final futureSelectedFriendList =
        state.friendList?.map((futureEntity) async {
      final result = await futureEntity;
      return result.fold(
        (failure) => false,
        (entity) => sharedFriendList?.contains(entity.userId) ?? false,
      );
    }).toList();

    state.selectedFriendList = futureSelectedFriendList == null
        ? null
        : await Future.wait(futureSelectedFriendList);
  }

  Future<void> loadGroupList() async {
    state.groupModelList = await getGroupListUsecase.call(NoParams()).then(
          (result) => result.fold(
            (failure) => null,
            (groupList) {
              return Future.wait(
                groupList.map((groupEntity) async {
                  return getGroupListViewCellWidgetModelUsecase
                      .call(groupEntity: groupEntity)
                      .then(
                        (result) => result.fold(
                          (failure) => GroupListViewCellWidgetModel.dummyModel,
                          (model) => model,
                        ),
                      );
                }).toList(),
              );
            },
          ),
        );

    final sharedGroupList = state.resolutionEntity?.shareGroupEntityList
        ?.map((entity) => entity.groupId)
        .toList();

    final selectedGroupList = state.groupModelList?.map((model) {
      return sharedGroupList?.contains(model.groupEntity.groupId) ?? false;
    }).toList();

    state.selectedGroupList = selectedGroupList;
  }

  Future<void> resetTempFriendList() async {
    state.tempSelectedFriendList = state.selectedFriendList?.toList();
  }

  Future<void> resetTempGroupList() async {
    state.tempSelectedGroupList = state.selectedGroupList?.toList();
  }

  Future<void> applyChangedSharingOfFriends() async {
    state.selectedFriendList!.forEachIndexed(
      (index, value) async {
        if (state.tempSelectedFriendList![index] != value) {
          final userId = await state.friendList?[index].then(
            (value) => value.fold(
              (failure) => null,
              (entity) => entity.userId,
            ),
          );

          if (userId != null && state.resolutionEntity?.resolutionId != null) {
            // 공유하기
            if (state.tempSelectedFriendList![index]) {
              shareResolutionToFriendUsecase
                  .call(
                    resolutionId: state.resolutionEntity!.resolutionId!,
                    friendId: userId,
                  )
                  .then(
                    (result) => result.fold(
                      (failure) => null,
                      (success) {
                        state.selectedFriendList?[index] =
                            state.tempSelectedFriendList![index];
                      },
                    ),
                  );
            }
            // 공유 취소하기
            else {
              unshareResolutionToFriendUsecase
                  .call(
                    resolutionId: state.resolutionEntity!.resolutionId!,
                    friendId: userId,
                  )
                  .then(
                    (result) => result.fold(
                      (failure) => null,
                      (success) {
                        state.selectedFriendList?[index] =
                            state.tempSelectedFriendList![index];
                      },
                    ),
                  );
            }
          }
        }
      },
    );
  }

  Future<void> applyChangedSharingOfGroups() async {
    state.selectedGroupList!.forEachIndexed(
      (index, value) async {
        if (state.tempSelectedGroupList![index] != value) {
          final groupId = state.groupModelList?[index].groupEntity.groupId;

          if (groupId != null && state.resolutionEntity?.resolutionId != null) {
            // 공유하기
            if (state.tempSelectedGroupList![index]) {
              shareResolutionToGroupUsecase
                  .call(
                    resolutionId: state.resolutionEntity!.resolutionId!,
                    groupId: groupId,
                  )
                  .then(
                    (result) => result.fold(
                      (failure) => null,
                      (success) {
                        state.selectedGroupList?[index] =
                            state.tempSelectedGroupList![index];
                      },
                    ),
                  );
            }
            // 공유 취소하기
            else {
              unshareResolutionToGroupUsecase
                  .call(
                    resolutionId: state.resolutionEntity!.resolutionId!,
                    groupId: groupId,
                  )
                  .then(
                    (result) => result.fold(
                      (failure) => null,
                      (success) {
                        state.selectedGroupList?[index] =
                            state.tempSelectedGroupList![index];
                      },
                    ),
                  );
            }
          }
        }
      },
    );
  }
}
