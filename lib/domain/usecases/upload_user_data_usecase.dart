import 'dart:io';

import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/domain/domain.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadUserDataUsecase {
  UploadUserDataUsecase(
    this._userModelRepository,
  );

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({
    required String uid,
    required String name,
    required File userImageFile,
    required String aboutMe,
    required String handle,
  }) async {
    return _userModelRepository.registerUserData(
      uid: uid,
      name: name,
      userImageFile: userImageFile,
      aboutMe: aboutMe,
      handle: handle,
    );
  }
}
