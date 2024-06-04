import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class AddResolutionViewModelProvider
    extends StateNotifier<AddResolutionViewModel> {
  AddResolutionViewModelProvider() : super(AddResolutionViewModel());

  void setTimes(double value) {
    state.timesTemp = value;
    state.times = value.round();
    if (state.times == 7) {
      state.timesLabel = '매일매일';
    } else {
      state.timesLabel = '${state.times}일';
    }
  }

  void setTimesOnChangeEnd(double value) {
    state.timesTemp = value.roundToDouble();
  }

  void setIconIndex(int value) {
    state.iconIndex = value;
  }

  void setNameString(String value) {
    if (value.isEmpty) {
      state.inputConditions[0] = false;
    } else {
      state.inputConditions[0] = true;
    }
    state.name = value;
    checkIsMovableToNextStep();
  }

  void setGoalString(String value) {
    if (value.isEmpty) {
      state.inputConditions[1] = false;
    } else {
      state.inputConditions[1] = true;
    }
    state.goal = value;
    checkIsMovableToNextStep();
  }

  void setActionString(String value) {
    if (value.isEmpty) {
      state.inputConditions[2] = false;
    } else {
      state.inputConditions[2] = true;
    }
    state.action = value;
    checkIsMovableToNextStep();
  }

  void checkIsMovableToNextStep() {
    state.isMovableToNextStep = state.inputConditions
        .sublist(0, state.currentStep + 1)
        .reduce((value, element) => value & element);
  }

  void setFocusedStep(int value) {
    state.focusedStep = value;
  }
}
