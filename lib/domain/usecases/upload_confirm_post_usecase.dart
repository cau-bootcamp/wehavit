import 'package:flutter/material.dart';
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
    required String content,
    required List<String> localFileUrlList,
    required bool hasRested,
  }) async {
    try {
      final networkImageUrlList = await Future.wait(
        localFileUrlList.map((url) async {
          final networkImageUrl = await _confirmPostRepository
              .uploadConfirmPostImage(localFileUrl: url)
              .then(
                (value) => value.fold(
                  (failure) => null,
                  (imageUrl) => imageUrl,
                ),
              );

          if (networkImageUrl == null) {
            debugPrint('cannot upload confirm post photo');
            throw const Failure('cannot upload confirm post photo');
          }

          return networkImageUrl;
        }).toList(),
      );

      final uid = (await _userModelRepository.getMyUserId()).fold(
        (failure) => null,
        (uid) => uid,
      );

      if (uid == null) {
        debugPrint('cannot get uid');
        return Future(() => left(const Failure('cannot get uid')));
      }

      final confirmPost = ConfirmPostEntity(
        resolutionGoalStatement: resolutionGoalStatement,
        resolutionId: resolutionId,
        content: content,
        imageUrlList: networkImageUrlList,
        owner: uid,
        recentStrike: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        hasRested: hasRested,
      );

      return await _confirmPostRepository.createConfirmPost(confirmPost);
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
