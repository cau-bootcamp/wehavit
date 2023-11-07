import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase_provider.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/get_today_confirm_post_list_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/get_today_confirm_post_list_usecase_proivder.dart';
import 'package:wehavit/features/swipe_view/presentation/widget/swipe_view_cell.dart';

final swipeViewProvider = StateNotifierProvider<SwipeViewProvider,
    Either<Failure, List<ConfirmPostModel>>>((ref) => SwipeViewProvider(ref));

class SwipeViewProvider
    extends StateNotifier<Either<Failure, List<ConfirmPostModel>>> {
  SwipeViewProvider(Ref ref) : super(const Right([])) {
    _getTodayConfirmPostListUsecase =
        ref.watch(getTodayConfirmPostListUsecaseProvider);
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
  }

  late final GetTodayConfirmPostListUsecase _getTodayConfirmPostListUsecase;
  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;

  Future<void> getTodayConfirmPostModelList() async {
    final confirmPostModelFetchResult =
        await _getTodayConfirmPostListUsecase.call(NoParams());

    state = confirmPostModelFetchResult;
  }

  Future<UserModel> getUserModelFromId(String targetUserId) async {
    final fetchResult = await _fetchUserDataFromIdUsecase.call(targetUserId);
    fetchResult.fold((l) {
      return Future(
        () => UserModel(
          displayName: 'good',
          email: 'email',
          imageUrl:
              'https://media.istockphoto.com/id/961829842/ko/사진/나쁜-고양이-은행-강도.jpg?s=1024x1024&w=is&k=20&c=7mc4cum-tQaOlV0R9xGD0LINLMmho2OpV9FYZigIgfI=',
        ),
      );
    }, (r) {
      return Future(
        () => UserModel(
          displayName: 'good',
          email: 'email',
          imageUrl:
              'https://media.istockphoto.com/id/961829842/ko/사진/나쁜-고양이-은행-강도.jpg?s=1024x1024&w=is&k=20&c=7mc4cum-tQaOlV0R9xGD0LINLMmho2OpV9FYZigIgfI=',
        ),
      );
    });

    throw UnimplementedError();
  }
}
