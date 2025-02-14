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
    required List<String> fileUrlList,
    required bool hasRested,
    required bool isPostingForYesterday,
  }) async {
    try {
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
        imageUrlList: fileUrlList,
        owner: uid,
        createdAt: DateTime.now().subtract(Duration(days: isPostingForYesterday ? 1 : 0)),
        updatedAt: DateTime.now(),
        hasRested: hasRested,
      );

      return await _confirmPostRepository.createConfirmPost(confirmPost).then((result) {
        return result.fold((failure) {
          return left(failure);
        }, (success) {
          return right(success);
        });
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
