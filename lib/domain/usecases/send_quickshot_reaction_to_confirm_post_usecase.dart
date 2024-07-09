import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SendQuickShotReactionToConfirmPostUsecase
    extends FutureUseCase<void, (ConfirmPostEntity, String)> {
  SendQuickShotReactionToConfirmPostUsecase(
    this._reactionRepository,
    this._userModelRepository,
    this._photoRepository,
    this._resolutionRepository,
  );
  final ReactionRepository _reactionRepository;
  final UserModelRepository _userModelRepository;
  final PhotoRepository _photoRepository;
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

    final imageUploadResult =
        await _photoRepository.uploadPhotoForConfirmPostAndGetDownloadUrl(
      localPhotoUrl: params.$2,
      entity: params.$1,
    );

    final uploadedImageUrl = imageUploadResult.fold(
      (l) => null,
      (uploadedImageUrl) => uploadedImageUrl,
    );

    if (uploadedImageUrl == null) {
      return Future(
        () => left(const Failure('fail to upload quickshot photo')),
      );
    }

    final reactionEntity = ReactionEntity.quickShotType(
      complimenterUid: myUid,
      quickShotUrl: uploadedImageUrl,
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
