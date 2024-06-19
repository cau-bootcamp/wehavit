import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class SignUpUserDataViewModelProvider
    extends StateNotifier<SignUpUserDataViewModel> {
  SignUpUserDataViewModelProvider(
    this.uploadUserDataUsecase,
    this.removeCurrentUserDataUsecase,
    this.logOutUseCase,
  ) : super(SignUpUserDataViewModel());

  UploadUserDataUsecase uploadUserDataUsecase;
  RemoveCurrentUserDataUsecase removeCurrentUserDataUsecase;
  LogOutUsecase logOutUseCase;

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      state.profileImageFile = File(pickedFile.path);
    }
  }

  void setName(String value) {
    state.name = value;
  }

  void setHandle(String value) {
    state.handle = value;
  }

  void setAboutMe(String value) {
    state.aboutMe = value;
  }

  EitherFuture<void> registerUserData() async {
    if (state.profileImageFile == null) {
      return Future(() => left(const Failure('no-image-file')));
    }
    if (state.handle.isEmpty) {
      return Future(() => left(const Failure('no-handle')));
    }

    return await uploadUserDataUsecase(
      uid: state.uid,
      name: state.name,
      userImageFile: state.profileImageFile!,
      aboutMe: state.aboutMe,
      handle: state.handle,
    ).then((result) {
      return result.fold(
        (failure) => left(failure),
        (success) => right(null),
      );
    });
  }

  EitherFuture<void> removeUserData() async {
    return removeCurrentUserDataUsecase.call();
  }

  Future<void> logOut() {
    return logOutUseCase.call();
  }
}
