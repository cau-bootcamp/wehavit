import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/write_post/model/add_resolution_done_view_model.dart';

class AddResolutionDoneViewModelProvider
    extends StateNotifier<AddResolutionDoneViewModel> {
  AddResolutionDoneViewModelProvider(this.getFriendListUsecase,
      this.getGroupListUsecase, this.getGroupListViewCellWidgetModelUsecase)
      : super(AddResolutionDoneViewModel());

  GetFriendListUsecase getFriendListUsecase;
  GetGroupListUsecase getGroupListUsecase;
  GetGroupListViewCellWidgetModelUsecase getGroupListViewCellWidgetModelUsecase;

  void toggleFriendSelection(index) {
    if (state.selectedFriendList != null) {
      state.selectedFriendList![index] = !state.selectedFriendList![index];
    }
  }

  void toggleGroupSelection(index) {
    if (state.selectedGroupList != null) {
      state.selectedGroupList![index] = !state.selectedGroupList![index];
    }
  }

  Future<void> loadFriendList() async {
    state.friendList = await getFriendListUsecase.call().then(
          (result) => result.fold(
            (failure) => null,
            (list) => list,
          ),
        );
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
  }
}
