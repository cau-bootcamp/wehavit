import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';
import 'package:wehavit/domain/usecases/get_confirm_post_list_for_resolution_id.dart';
import 'package:wehavit/domain/usecases/get_resolution_list_usecase.dart';

final myPageResolutionListProvider = StateNotifierProvider<
    MyPageResolutionListProvider,
    Either<Failure,
        (List<ResolutionModel>, List<Future<List<ConfirmPostModel>>>)>>((ref) {
  return MyPageResolutionListProvider(ref);
});

class MyPageResolutionListProvider extends StateNotifier<
    Either<Failure,
        (List<ResolutionModel>, List<Future<List<ConfirmPostModel>>>)>> {
  MyPageResolutionListProvider(Ref ref) : super(const Right(([], []))) {
    getResolutionListUsecase = ref.watch(getResolutionListUseCaseProvider);
    getConfirmPostListForResolutionIdUsecase =
        ref.watch(getConfirmPostListForResolutionIdUsecaseProvider);
  }

  late final GetResolutionListUsecase getResolutionListUsecase;
  late final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;

  Future<void> getActiveResolutionList() async {
    final resolutionFetchResult = await getResolutionListUsecase(NoParams());

    final List<ResolutionModel> resolutionList = resolutionFetchResult.fold(
      (failure) => [],
      (fetchResult) => fetchResult,
    );

    final List<Future<List<ConfirmPostModel>>> confirmPostList =
        resolutionList.map((resolutionModel) async {
      final confirmListFetchResult =
          await getConfirmPostListForResolutionIdUsecase(
        resolutionModel.resolutionId,
      );

      final List<ConfirmPostModel> confirmList = confirmListFetchResult.fold(
        (failure) => [],
        (fetchResult) => fetchResult,
      );

      return confirmList;
    }).toList();

    state = right((resolutionList, confirmPostList));
  }
}
