import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadQuickshotPresetUsecase {
  UploadQuickshotPresetUsecase(
    this._userModelRepository,
    this._photoRepository,
  );

  final UserModelRepository _userModelRepository;
  final PhotoRepository _photoRepository;

  EitherFuture<void> call({
    required String localFileUrl,
  }) async {
    try {
      final networkImageUrl = await _photoRepository
          .uploadQuickshotPresetImage(localPhotoUrl: localFileUrl)
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

      final uid = (await _userModelRepository.getMyUserId()).fold(
        (failure) => null,
        (uid) => uid,
      );

      if (uid == null) {
        debugPrint('cannot get uid');
        return Future(() => left(const Failure('cannot get uid')));
      }

      return await _userModelRepository
          .uploadQuickshotPreset(networkImageUrl)
          .then((result) {
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
