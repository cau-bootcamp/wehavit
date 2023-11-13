import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/domain/repository/swipe_view_repository_proivder.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/send_reaction_to_target_confirm_post.dart';

final sendReactionToTargetConfirmPostUsecaseProvider =
    Provider<SendReactionToTargetConfirmPostUsecase>((ref) {
  final _swipeViewRepository = ref.watch(swipeViewRepositoryProvider);
  return SendReactionToTargetConfirmPostUsecase(_swipeViewRepository);
});
