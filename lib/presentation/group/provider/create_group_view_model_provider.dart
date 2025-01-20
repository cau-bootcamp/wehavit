import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group/group.dart';

class CreateGroupViewModelProvider extends StateNotifier<CreateGroupViewModel> {
  CreateGroupViewModelProvider(this._createGroupUsecase) : super(CreateGroupViewModel());

  final CreateGroupUsecase _createGroupUsecase;

  void setGroupName(String value) {
    if (value.isEmpty) {
      state.inputConditions[0] = false;
    } else {
      state.inputConditions[0] = true;
    }
    state.groupName = value;
  }

  void setGroupDescription(String value) {
    if (value.isEmpty) {
      state.inputConditions[1] = false;
    } else {
      state.inputConditions[1] = true;
    }
    state.groupDescription = value;
  }

  void setGroupRule(String value) {
    if (value.isEmpty) {
      state.inputConditions[2] = false;
    } else {
      state.inputConditions[2] = true;
    }
    state.groupRule = value;
  }

  void setGroupColorIndex(int value) {
    state.groupColorIndex = value;
  }

  void scrollDown() {
    state.scrollController.jumpTo(state.scrollController.position.maxScrollExtent);
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

  void setFocusedStep(int value) {
    state.focusedStep = value;
  }
}
