import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/reaction_repository_impl.dart';
import 'package:wehavit/data/repositories/user_model_repository_impl.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final sendCommentReactionToConfirmPostUsecaseProvider =
    Provider<SendCommentReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return SendCommentReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
  );
});

class SendCommentReactionToConfirmPostUsecase
    extends FutureUseCase<void, (String, String)> {
  SendCommentReactionToConfirmPostUsecase(
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

    final reactionEntity = ReactionEntity.commentType(
      complimenterUid: myUid,
      comment: params.$2,
    );

    return _reactionRepository.addReactionToConfirmPost(
      params.$1,
      reactionEntity,
    );
  }
}
