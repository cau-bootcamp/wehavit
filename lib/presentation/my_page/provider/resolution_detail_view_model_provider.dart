import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/my_page/model/resolution_detail_view_model.dart';

class ResolutionDetailViewModelProvider
    extends StateNotifier<ResolutionDetailViewModel> {
  ResolutionDetailViewModelProvider(
    this.getConfirmPostListForResolutionIdUsecase,
  ) : super(ResolutionDetailViewModel());

  final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;

  Future<void> changeSelectedDate({required DateTime to}) async {
    state.selectedDate = to;
  }

  Future<void> loadConfirmPosts({
    required String resolutionId,
    required DateTime mondayOfTargetWeek,
  }) async {
    getConfirmPostListForResolutionIdUsecase.call(resolutionId);

    return Future(() => null);
  }
}
