import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

import '../../../domain/entities/resolution_entity/resolution_entity.dart';

class AddResolutionViewModelProvider
    extends StateNotifier<AddResolutionViewModel> {
  AddResolutionViewModelProvider(
    this.uploadResolutionUseCase,
  ) : super(AddResolutionViewModel());

  UploadResolutionUseCase uploadResolutionUseCase;

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

  Future<ResolutionEntity?> uploadResolution() async {
    return uploadResolutionUseCase
        .call(
          resolutionName: state.name,
          goalStatement: state.goal,
          actionStatement: state.action,
          shareFriendList: [],
          shareGroupList: [],
          actionPerWeek: state.times,
          colorIndex: state.pointColorIndex,
          iconIndex: state.iconIndex,
        )
        .then(
          (result) => result.fold(
            (failure) => null,
            (resolutionEntity) => resolutionEntity,
          ),
        );
  }

  void setColorIndex(int index) {
    state.pointColorIndex = index;
  }
}
