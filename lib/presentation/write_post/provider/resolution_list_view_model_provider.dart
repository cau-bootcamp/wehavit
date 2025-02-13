import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionListViewModelProvider extends StateNotifier<ResolutionListViewModel> {
  ResolutionListViewModelProvider(
    this.ref,
    this._getMyResolutionListUsecase,
    this._getTargetResolutionDoneListForWeekUsecase,
    this._uploadConfirmPostUseCase,
  ) : super(ResolutionListViewModel());

  final Ref ref;
  final GetMyResolutionListUsecase _getMyResolutionListUsecase;
  final GetTargetResolutionDoneListForWeekUsecase _getTargetResolutionDoneListForWeekUsecase;
  final UploadConfirmPostUseCase _uploadConfirmPostUseCase;

  Future<void> loadResolutionModelList() async {
    state.isLoadingView = false;

    final resolutionList = await _getMyResolutionListUsecase().then(
      (result) => result.fold(
        (failure) => null,
        (result) => result,
      ),
    );

    if (resolutionList == null) {
      state.resolutionModelList = null;

      return;
    }

    EitherFuture<List<bool>> doneList;
    final List<ResolutionListCellWidgetModel> modelList = await Future.wait(
      resolutionList.map((entity) async {
        doneList = _getTargetResolutionDoneListForWeekUsecase(
          param: GetTargetResolutionDoneListForWeekUsecaseParams(
            resolutionId: entity.resolutionId,
            startMonday: DateTime.now().getMondayDateTime(),
          ),
        );

        return ResolutionListCellWidgetModel(
          entity: entity,
          doneList: doneList,
        );
      }).toList(),
    );

    state = state.copyWith(newResolutionModelList: modelList);

    int tempTotalCount = 0;
    state.futureDoneCount = Future(() async {
      final dones = modelList.map((model) {
        tempTotalCount += model.entity.actionPerWeek;
        return model.doneList;
      }).toList();

      int tempDoneCount = 0;
      for (final doneList in dones) {
        (await doneList).fold((l) => null, (r) {
          tempDoneCount += r.where((element) => element == true).length;
        });
      }

      return Future(() => right(tempDoneCount));
    });

    state.futureDoneRatio = Future(() async {
      return state.futureDoneCount!.then(
        (result) => result.fold(
          (failure) => Future(() => left(const Failure(''))),
          (doneCount) => Future(
            () {
              if (tempTotalCount == 0) {
                return left(const Failure('total post count of week is 0'));
              }
              return right((doneCount / tempTotalCount * 100).round());
            },
          ),
        ),
      );
    });

    state.isLoadingView = false;
  }

  Future<void> uploadPostWithoutContents({
    required ResolutionEntity entity,
  }) async {
    _uploadConfirmPostUseCase(
      resolutionGoalStatement: entity.goalStatement,
      resolutionId: entity.resolutionId,
      content: '',
      localFileUrlList: [],
      hasRested: false,
      isPostingForYesterday: false,
    ).then((result) {
      final isPostingSuccess = result.fold((failure) => false, (value) => value);

      if (isPostingSuccess) {
        ref.invalidate(
          weeklyResolutionInfoProvider.call(
            WeeklyResolutionInfoProviderParam(
              resolutionId: entity.resolutionId,
              startMonday: DateTime.now().getMondayDateTime(),
            ),
          ),
        );
      }
    });
  }
}
