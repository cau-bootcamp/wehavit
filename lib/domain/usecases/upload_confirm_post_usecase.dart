import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadConfirmPostUseCase {
  UploadConfirmPostUseCase(
    this._confirmPostRepository,
    this._userModelRepository,
  );

  final ConfirmPostRepository _confirmPostRepository;
  final UserModelRepository _userModelRepository;

  EitherFuture<bool> call({
    required String resolutionGoalStatement,
    required String resolutionId,
    required String title,
    required String content,
    required String imageUrl,
    required List<UserDataEntity> fan,
    required Map<String, bool> attributes,
  }) async {
    final networkImageUrl = (await _confirmPostRepository
            .uploadConfirmPostImage(localFileUrl: imageUrl))
        .fold(
      (failure) => null,
      (imageUrl) => imageUrl,
    );

    if (networkImageUrl == null) {
      return Future(
          () => left(const Failure('cannot upload confirm post photo')));
    }

    final uid = (await _userModelRepository.getMyUserId()).fold(
      (failure) => null,
      (uid) => uid,
    );

    if (uid == null) {
      return Future(() => left(const Failure('cannot get uid')));
    }

    final confirmPost = ConfirmPostEntity(
      resolutionGoalStatement: resolutionGoalStatement,
      resolutionId: resolutionId,
      title: title,
      content: content,
      imageUrl: networkImageUrl,
      owner: uid,
      fan: fan,
      recentStrike: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      attributes: attributes,
    );

    return await _confirmPostRepository.createConfirmPost(confirmPost);
  }
}
