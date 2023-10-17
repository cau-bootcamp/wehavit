import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/domain/models/add_resolution_model.dart';
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

  Future<Either<Failure, bool>> uploadResolutionModel() {
    AddResolutionModel newModel = AddResolutionModel(
      goalStatement: state.goalStatement,
      actionStatement: state.actionStatement,
      oathStatement: state.oathStatement,
      isDaySelectedList: state.isDaySelectedList,
    );

    return _uploadResolutionUsecase.call(newModel);
  }
}
