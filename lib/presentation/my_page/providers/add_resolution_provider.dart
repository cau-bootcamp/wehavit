import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

class AddResolutionNotifier extends StateNotifier<ResolutionEntity> {
  AddResolutionNotifier(Ref ref) : super(const ResolutionEntity()) {
    _uploadResolutionUsecase = ref.watch(uploadResolutionUsecaseProvider);
  }

  late final UploadResolutionUseCase _uploadResolutionUsecase;

  void changeFanList(List<UserDataEntity> newFanList) {
    state = state.copyWith(fanList: newFanList);
  }

  void changePeriodState(List<bool> isDaySelectedList) {
    // state = state.copyWith(isDaySelectedList: isDaySelectedList);
  }

  void changeGoalStatement(String newStatement) {
    state = state.copyWith(goalStatement: newStatement);
  }

  void changeActionStatement(String newStatement) {
    state = state.copyWith(actionStatement: newStatement);
  }

  void changeOathStatement(String newStatement) {
    // state = state.copyWith(oathStatement: newStatement);
  }

  EitherFuture<bool> uploadResolutionEntity() {
    return _uploadResolutionUsecase(
      goalStatement: state.goalStatement!,
      actionStatement: state.actionStatement!,
      fanList: state.fanList!,
      actionPerWeek: 3,
    );
  }
}
