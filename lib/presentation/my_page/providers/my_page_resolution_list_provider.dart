import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

final myPageResolutionListProvider = StateNotifierProvider<
    MyPageResolutionListProvider,
    Either<
        Failure,
        (
          List<ResolutionEntity>,
          List<Future<List<ConfirmPostEntity>>>
        )>>((ref) {
  return MyPageResolutionListProvider(ref);
});

class MyPageResolutionListProvider extends StateNotifier<
    Either<Failure,
        (List<ResolutionEntity>, List<Future<List<ConfirmPostEntity>>>)>> {
  MyPageResolutionListProvider(Ref ref) : super(const Right(([], []))) {
    getResolutionListUsecase =
        ref.watch(getResolutionListByUserIdUsecaseProvider);
    getMyResolutionListUsecase =
        ref.watch(getMyResolutionListByUserIdUsecaseProvider);
    getConfirmPostListForResolutionIdUsecase =
        ref.watch(getConfirmPostListForResolutionIdUsecaseProvider);
  }

  late final GetResolutionListByUserIdUsecase getResolutionListUsecase;
  late final GetMyResolutionListByUserIdUsecase getMyResolutionListUsecase;
  late final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;

  Future<void> getMyActiveResolutionList() async {
    final resolutionFetchResult = await getMyResolutionListUsecase(NoParams());

    final List<ResolutionEntity> resolutionList = resolutionFetchResult.fold(
      (failure) => [],
      (fetchResult) => fetchResult,
    );

    final List<Future<List<ConfirmPostEntity>>> confirmPostList =
        resolutionList.map((resolutionModel) async {
      final confirmListFetchResult =
          await getConfirmPostListForResolutionIdUsecase(
        resolutionModel.resolutionId ?? 'no',
      );

      final List<ConfirmPostEntity> confirmList = confirmListFetchResult.fold(
        (failure) => [],
        (fetchResult) => fetchResult,
      );

      return confirmList;
    }).toList();

    state = right((resolutionList, confirmPostList));
  }
}
