import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/home/domain/repositories/confirm_post_repository_provider.dart';
import 'package:wehavit/features/home/domain/usecases/get_confirm_post_list_usecase.dart';

final getConfirmPostListUsecaseProvider =
    Provider<GetConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListUsecase(confirmPostRepository);
});
