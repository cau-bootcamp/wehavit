import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/my_page/model/resolution_detail_view_model.dart';

class ResolutionDetailViewModelProvider
    extends StateNotifier<ResolutionDetailViewModel> {
  ResolutionDetailViewModelProvider(
    this.getConfirmPostListForResolutionIdUsecase,
    this.getConfirmPostOfDatetimeFromTargetResolutionUsecase,
  ) : super(ResolutionDetailViewModel());

  final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;
  final GetConfirmPostOfDatetimeFromTargetResolutionUsecase
      getConfirmPostOfDatetimeFromTargetResolutionUsecase;

  Future<void> changeSelectedDate({required DateTime to}) async {
    state.selectedDate = to;
  }

  Future<void> loadConfirmPostsForWeek({
    required DateTime mondayOfTargetWeek,
  }) async {
    for (int i = 0; i < 7; i++) {
      await loadConfirmPostEntityListFor(
        dateTime: mondayOfTargetWeek.add(Duration(days: i)),
      );
    }
    return Future(() => null);
  }

  Future<void> loadConfirmPostEntityListFor({
    required DateTime dateTime,
  }) async {
    final selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (state.resolutionEntity == null ||
        state.resolutionEntity?.resolutionId == null) {
      return;
    }

    state.confirmPostList[selectedDate] =
        getConfirmPostOfDatetimeFromTargetResolutionUsecase.call(
      resolutionId: state.resolutionEntity!.resolutionId!,
      targetDateTime: dateTime,
    );
  }
}
