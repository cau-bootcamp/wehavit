import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/user_data_entity/friend_model.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';
import 'package:wehavit/domain/usecases/upload_resolution_usecase.dart';

final addResolutionProvider =
    StateNotifierProvider.autoDispose<AddResolutionNotifier, ResolutionModel>(
        (ref) {
  return AddResolutionNotifier(ref);
});

class AddResolutionNotifier extends StateNotifier<ResolutionModel> {
  AddResolutionNotifier(Ref ref) : super(ResolutionModel()) {
    _uploadResolutionUsecase = ref.watch(uploadResolutionUsecaseProvider);
  }

  late final UploadResolutionUseCase _uploadResolutionUsecase;

  void changeFanList(List<UserDataEntity> newFanList) {
    state = state.copyWith(fanList: newFanList);
  }

  void changePeriodState(List<bool> isDaySelectedList) {
    state = state.copyWith(isDaySelectedList: isDaySelectedList);
  }

  void changeGoalStatement(String newStatement) {
    state = state.copyWith(goalStatement: newStatement);
  }

  void changeActionStatement(String newStatement) {
    state = state.copyWith(actionStatement: newStatement);
  }

  void changeOathStatement(String newStatement) {
    state = state.copyWith(oathStatement: newStatement);
  }

  EitherFuture<bool> uploadResolutionModel() {
    ResolutionModel newModel = ResolutionModel(
      goalStatement: state.goalStatement,
      actionStatement: state.actionStatement,
      oathStatement: state.oathStatement,
      isDaySelectedList: state.isDaySelectedList,
      isActive: true,
      startDate: DateTime.now(),
      fanList: state.fanList,
      resolutionId: '',
    );
    return _uploadResolutionUsecase.call(newModel);
  }
}
