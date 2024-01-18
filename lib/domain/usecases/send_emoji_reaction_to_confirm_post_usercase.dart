import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/reaction_repository_impl.dart';
import 'package:wehavit/data/repositories/user_model_repository_impl.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final sendEmojiReactionToConfirmPostUsecaseProvider =
    Provider<SendEmojiReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  return SendEmojiReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
  );
});

class SendEmojiReactionToConfirmPostUsecase
    extends FutureUseCase<void, (String, Map<String, int>)> {
  SendEmojiReactionToConfirmPostUsecase(
    this._reactionRepository,
    this._userModelRepository,
  );
  final ReactionRepository _reactionRepository;
  final UserModelRepository _userModelRepository;

  @override
  EitherFuture<bool> call((String, Map<String, int>) params) async {
    final uidFetchResult = await _userModelRepository.getMyUserId();
    final myUid = uidFetchResult.fold(
      (l) => null,
      (uid) => uid,
    );

    if (myUid == null) {
      return Future(() => left(const Failure('cannot get my user id')));
    }

    final reactionEntity = ReactionEntity.emojiType(
      complimenterUid: myUid,
      emoji: params.$2,
    );

    return _reactionRepository.addReactionToConfirmPost(
      params.$1,
      reactionEntity,
    );
  }
}
