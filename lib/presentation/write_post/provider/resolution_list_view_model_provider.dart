import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionListViewModelProvider
    extends StateNotifier<ResolutionListViewModel> {
  ResolutionListViewModelProvider(
    this._getMyResolutionListUsecase,
    this._getTargetResolutionDoneCountForWeekUsecase,
    this._uploadConfirmPostUseCase,
  ) : super(ResolutionListViewModel());

  final GetMyResolutionListUsecase _getMyResolutionListUsecase;
  final GetTargetResolutionDoneCountForWeekUsecase
      _getTargetResolutionDoneCountForWeekUsecase;
  final UploadConfirmPostUseCase _uploadConfirmPostUseCase;

  Future<void> loadResolutionModelList() async {
    final resolutionList = await _getMyResolutionListUsecase(NoParams()).then(
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
          successCount = await _getTargetResolutionDoneCountForWeekUsecase(
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

    state.summaryDoneCount = 0;
    state.summaryTotalCount = 0;
    for (final element in modelList) {
      state.summaryTotalCount += element.entity.actionPerWeek ?? 7;
      state.summaryDoneCount += element.successCount;
    }
  }

  Future<void> uploadPostWithoutContents({
    required ResolutionListCellWidgetModel model,
  }) async {
    _uploadConfirmPostUseCase(
      resolutionGoalStatement: model.entity.goalStatement ?? '',
      resolutionId: model.entity.resolutionId ?? '',
      content: '',
      localFileUrlList: [],
      hasRested: false,
    );
  }
}
