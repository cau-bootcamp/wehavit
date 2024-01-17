import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/reaction_repository_impl.dart';
import 'package:wehavit/data/repositories/user_model_repository_impl.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';

final sendQuickShotReactionToConfirmPostUsecaseProvider =
    Provider<SendQuickShotReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return SendQuickShotReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
  );
});

class SendQuickShotReactionToConfirmPostUsecase
    extends FutureUseCase<void, (String, String)> {
  SendQuickShotReactionToConfirmPostUsecase(
    this._reactionRepository,
    this._userModelRepository,
  );
  final ReactionRepository _reactionRepository;
  final UserModelRepository _userModelRepository;

  @override
  EitherFuture<bool> call((String, String) params) async {
    final uidFetchResult = await _userModelRepository.getMyUserId();
    final myUid = uidFetchResult.fold(
      (l) => null,
      (uid) => uid,
    );

    if (myUid == null) {
      return Future(() => left(const Failure('cannot get my user id')));
    }

    final reactionEntity = ReactionEntity.quickShotType(
      confirmPostId: 'upload',
      complimenterUid: myUid,
      quickShotUrl: '',
    );

    return _reactionRepository.addReactionToConfirmPost(
      params.$1,
      reactionEntity,
    );
  }
}
