import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionListViewModelProvider
    extends StateNotifier<ResolutionListViewModel> {
  ResolutionListViewModelProvider(
    this.getMyResolutionListUsecase,
    this.getTargetResolutionDoneCountForWeekUsecase,
  ) : super(ResolutionListViewModel());

  GetMyResolutionListUsecase getMyResolutionListUsecase;
  GetTargetResolutionDoneCountForWeekUsecase
      getTargetResolutionDoneCountForWeekUsecase;

  Future<void> loadResolutionModelList() async {
    final resolutionList = await getMyResolutionListUsecase(NoParams()).then(
      (result) => result.fold(
        (failure) => null,
        (result) => result,
      ),
    );

    if (resolutionList == null) {
      state.resolutionModelList = null;
      return;
    }

    final List<ResolutionListCellWidgetModel> modelList = await Future.wait(
      resolutionList.map((entity) async {
        int successCount = 0;
        if (entity.resolutionId != null) {
          successCount = await getTargetResolutionDoneCountForWeekUsecase(
            resolutionId: entity.resolutionId ?? '',
          ).then(
            (result) => result.fold(
              (failure) => 0,
              (doneCount) => doneCount,
            ),
          );
        } else {
          successCount = 0;
        }

        return ResolutionListCellWidgetModel(
          entity: entity,
          successCount: successCount,
        );
      }).toList(),
    );

    state.resolutionModelList = modelList;
  }
}
