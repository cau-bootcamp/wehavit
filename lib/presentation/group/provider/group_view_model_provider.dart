import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group/group.dart';

class GroupViewModelProvider extends StateNotifier<GroupViewModel> {
  GroupViewModelProvider(
    this.getGroupListUsecase,
    this.getGroupListViewCellWidgetModelUsecase,
    this.getGroupListViewFriendCellWidgetModelUsecase,
    this.getSharedResolutionIdListFromFriendUidUsecase,
  ) : super(GroupViewModel());

  final GetGroupListUsecase getGroupListUsecase;
  final GetGroupListViewCellWidgetModelUsecase
      getGroupListViewCellWidgetModelUsecase;
  final GetGroupListViewFriendCellWidgetModelUsecase
      getGroupListViewFriendCellWidgetModelUsecase;
  final GetSharedResolutionIdListFromFriendUidUsecase
      getSharedResolutionIdListFromFriendUidUsecase;

  Future<void> loadMyGroupCellList() async {
    state.myGroupList = await getGroupListUsecase(NoParams()).then(
      (value) => value.fold((failure) {
        return null;
      }, (groupEntityList) {
        return groupEntityList;
      }),
    );

    print(state.myGroupList);

    if (state.myGroupList == null) {
      state.groupListViewCellModelList = null;
      return;
    }

    state.groupListViewCellModelList = (await Future.wait(
      state.myGroupList!.map(
        (groupEntity) async {
          final groupModel = await getGroupListViewCellWidgetModelUsecase(
            groupEntity: groupEntity,
          ).then(
            (value) => value.fold(
              (failure) => null,
              (model) => model,
            ),
          );

          if (groupModel != null) {
            return groupModel;
          }
        },
      ),
    ))
        .nonNulls
        .toList();
  }

  Future<void> loadFriendCellWidgetModel({
    required List<String> friendUidList,
  }) async {
    Map<String, List<String>> sharedResolutionIdMap = {};

    await Future.wait(
      friendUidList.map((uid) async {
        final result = await getSharedResolutionIdListFromFriendUidUsecase.call(
          targetUid: uid,
        );
        final list = result.fold(
          (failure) => <String>[], // 실패 시 빈 리스트 반환
          (list) => list, // 성공 시 리스트 반환
        );
        sharedResolutionIdMap[uid] = list;
      }),
    );

    state.groupListViewFriendCellModel =
        await getGroupListViewFriendCellWidgetModelUsecase(
      userIdList: friendUidList,
      sharedResolutionIdList:
          sharedResolutionIdMap.values.expand((list) => list).toList(),
    ).then((result) {
      return result.fold((failure) {
        return null;
      }, (model) {
        return model;
      });
    });

    state.groupListViewFriendCellModel?.friendIdResolutionMap =
        sharedResolutionIdMap;
  }

  Future<void> updateGroupEntity({required GroupEntity forEntity}) async {
    final groupIndex = state.myGroupList
            ?.indexWhere((element) => element.groupId == forEntity.groupId) ??
        -1;

    if (groupIndex >= 0) {
      state.myGroupList?[groupIndex] = forEntity;
    }
    final groupCellIndex = state.groupListViewCellModelList?.indexWhere(
          (element) => element.groupEntity.groupId == forEntity.groupId,
        ) ??
        -1;
    if (groupCellIndex >= 0) {
      final groupModel = await getGroupListViewCellWidgetModelUsecase(
        groupEntity: forEntity,
      ).then(
        (value) => value.fold(
          (failure) => null,
          (model) => model,
        ),
      );

      if (groupModel != null) {
        state.groupListViewCellModelList?[groupCellIndex] = groupModel;
      }
    }
  }
}
