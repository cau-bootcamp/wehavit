import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SendCommentReactionToConfirmPostUsecase extends FutureUseCase<void, (ConfirmPostEntity, String)> {
  SendCommentReactionToConfirmPostUsecase(
    this._reactionRepository,
    this._userModelRepository,
    this._resolutionRepository,
  );
  final ReactionRepository _reactionRepository;
  final UserModelRepository _userModelRepository;
  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<bool> call((ConfirmPostEntity, String) params) async {
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

    return _reactionRepository
        .addReactionToConfirmPost(
      params.$1,
      reactionEntity,
    )
        .whenComplete(() {
      _userModelRepository.incrementUserDataCounter(
        type: UserIncrementalDataType.reaction,
      );
      _resolutionRepository.incrementReceivedReactionCount(
        targetResolutionId: params.$1.resolutionId ?? '',
      );
    });
  }
}
