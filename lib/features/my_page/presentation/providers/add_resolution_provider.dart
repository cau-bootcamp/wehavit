import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';
import 'package:wehavit/features/my_page/domain/models/add_resolution_model.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/usecases/upload_resolution_usecase.dart';
import 'package:wehavit/features/my_page/domain/usecases/upload_resolution_usecase_provider.dart';

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
