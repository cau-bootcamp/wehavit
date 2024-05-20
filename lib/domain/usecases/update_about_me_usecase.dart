import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UpdateAboutMeUsecase {
  UpdateAboutMeUsecase(
    this._userModelRepository,
  );

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({
    required String newAboutMe,
  }) async {
    return _userModelRepository.updateAmoutMe(newAboutMe: newAboutMe);
  }
}
