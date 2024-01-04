import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/add_resolution_model.dart';
import 'package:wehavit/domain/entities/friend_model.dart';
import 'package:wehavit/domain/entities/resolution_model.dart';
import 'package:wehavit/domain/usecases/upload_resolution_usecase.dart';

final addResolutionProvider = StateNotifierProvider.autoDispose<
    AddResolutionNotifier, AddResolutionModel>((ref) {
  return AddResolutionNotifier(ref);
});

class AddResolutionNotifier extends StateNotifier<AddResolutionModel> {
  AddResolutionNotifier(Ref ref) : super(AddResolutionModel()) {
    _uploadResolutionUsecase = ref.watch(uploadResolutionUsecaseProvider);
  }

  late final UploadResolutionUseCase _uploadResolutionUsecase;

  void changeFanList(List<FriendModel> newFanList) {
    state = state.copyWith(fanList: newFanList);
  }

  void changePeriodState(int day) {
    state = state.copyWith(
      isDaySelectedList: state.getToggledDaySelectedList(day),
    );
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
      fanList: state.fanList.map((e) => e.friendEmail).toList(),
      resolutionId: '',
    );
    return _uploadResolutionUsecase.call(newModel);
  }
}
