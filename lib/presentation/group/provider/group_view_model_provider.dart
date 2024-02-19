import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/get_group_list_view_cell_widget_model_usecase.dart';
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

    state.myGroupList?.map(
      (groupEntity) async {
        return await getGroupListViewCellWidgetModelUsecase(
          groupEntity: groupEntity,
        );
      },
    );
  }
}
