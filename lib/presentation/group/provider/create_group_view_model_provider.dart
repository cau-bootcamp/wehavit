import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group/group.dart';

class CreateGroupViewModelProvider extends StateNotifier<CreateGroupViewModel> {
  CreateGroupViewModelProvider(this._createGroupUsecase)
      : super(CreateGroupViewModel());

  final CreateGroupUsecase _createGroupUsecase;

  bool isComplete() {
    return !state.stepDoneList.contains(false);
  }

  void setStepDoneList(int index, bool value) {
    state.stepDoneList[index] = value;
  }

  void setGroupName(String value) {
    state.groupName = value;
  }

  bool isGroupNameFilled() {
    return state.groupName.isNotEmpty;
  }

  void setDescriptionName(String value) {
    state.groupDescription = value;
  }

  bool isGroupDescriptionFilled() {
    return state.groupDescription.isNotEmpty;
  }

  void setGroupRule(String value) {
    state.groupRule = value;
  }

  bool isGroupRuleFilled() {
    return state.groupRule.isNotEmpty;
  }

  void setGroupColorIndex(int value) {
    state.groupColorIndex = value;
  }

  bool isGroupColorIndexFilled() {
    return state.groupColorIndex >= 0;
  }

  void scrollDown() {
    state.scrollController
        .jumpTo(state.scrollController.position.maxScrollExtent);
  }

  Future<GroupEntity?> createGroup() async {
    return _createGroupUsecase
        .call(
          groupName: state.groupName,
          groupDescription: state.groupDescription,
          groupRule: state.groupRule,
          groupColor: state.groupColorIndex,
        )
        .then(
          (result) => result.fold(
            (l) => null,
            (entity) => entity,
          ),
        );
  }
}
