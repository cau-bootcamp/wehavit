import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final sendQuickShotReactionToConfirmPostUsecaseProvider =
    Provider<SendQuickShotReactionToConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  final userModelRepository = ref.watch(userModelRepositoryProvider);
  final photoRepository = ref.watch(photoRepositoryProvider);

  return SendQuickShotReactionToConfirmPostUsecase(
    reactionRepository,
    userModelRepository,
    photoRepository,
  );
});

class SendQuickShotReactionToConfirmPostUsecase
    extends FutureUseCase<void, (String, String)> {
  SendQuickShotReactionToConfirmPostUsecase(
    this._reactionRepository,
    this._userModelRepository,
    this._photoRepository,
  );
  final ReactionRepository _reactionRepository;
  final UserModelRepository _userModelRepository;
  final PhotoRepository _photoRepository;

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

    final imageUploadResult =
        await _photoRepository.uploadPhotoForConfirmPostAndGetDownloadUrl(
      localPhotoUrl: params.$2,
      confirmPostId: params.$1,
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

    return _reactionRepository.addReactionToConfirmPost(
      params.$1,
      reactionEntity,
    );
  }
}
