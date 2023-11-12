import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/repositories/confirm_post_repository_provider.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/get_today_confirm_post_list_usecase.dart';

final getTodayConfirmPostListUsecaseProvider =
    Provider<GetTodayConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetTodayConfirmPostListUsecase(confirmPostRepository);
});
