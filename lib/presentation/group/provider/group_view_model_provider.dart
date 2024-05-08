import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group/group.dart';

class GroupViewModelProvider extends StateNotifier<GroupViewModel> {
  GroupViewModelProvider(
    this.getGroupListUsecase,
    this.getGroupListViewCellWidgetModelUsecase,
  ) : super(GroupViewModel());

  final GetGroupListUsecase getGroupListUsecase;
  final GetGroupListViewCellWidgetModelUsecase
      getGroupListViewCellWidgetModelUsecase;

  Future<void> loadMyGroupCellList() async {
    state.myGroupList = await getGroupListUsecase(NoParams()).then(
      (value) => value.fold((failure) {
        return null;
      }, (groupEntityList) {
        return groupEntityList;
      }),
    );

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

  Future<void> updateGroupEntity({required GroupEntity forEntity}) async {
    final groupIndex = state.myGroupList
            ?.indexWhere((element) => element.groupId == forEntity.groupId) ??
        -1;

    if (groupIndex >= 0) {
      state.myGroupList?[groupIndex] = forEntity;
    }
    final groupCellIndex = state.groupListViewCellModelList?.indexWhere(
            (element) => element.groupEntity.groupId == forEntity.groupId) ??
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
