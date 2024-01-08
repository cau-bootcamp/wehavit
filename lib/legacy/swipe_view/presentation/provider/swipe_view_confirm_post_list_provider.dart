import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/usecases/get_confirm_post_list_for_resolution_id.dart';

final swipeViewConfirmPostListProvider = StateNotifierProvider<
    SwipeViewConfirmPostListProvider, Future<List<ConfirmPostEntity>>>(
  (ref) => SwipeViewConfirmPostListProvider(ref),
);

class SwipeViewConfirmPostListProvider
    extends StateNotifier<Future<List<ConfirmPostEntity>>> {
  SwipeViewConfirmPostListProvider(Ref ref) : super(Future(() => [])) {
    getConfirmPostListForResolutionIdUsecase =
        ref.watch(getConfirmPostListForResolutionIdUsecaseProvider);
  }

  late final GetConfirmPostListForResolutionIdUsecase
      getConfirmPostListForResolutionIdUsecase;

  Future<List<ConfirmPostEntity>> getConfirmPostListFor({
    required String resolutionId,
  }) async {
    final confirmListFetchResult =
        await getConfirmPostListForResolutionIdUsecase(resolutionId);

    return Future(
      () => confirmListFetchResult.fold(
        (failure) => [],
        (modelList) => modelList,
      ),
    );
  }
}
