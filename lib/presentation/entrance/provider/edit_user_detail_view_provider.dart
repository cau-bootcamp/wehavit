import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class EditUserDataViewModelProvider
    extends StateNotifier<EditUserDetailViewModel> {
  EditUserDataViewModelProvider(
    this.uploadUserDataUsecase,
    this.removeCurrentUserDataUsecase,
    this.logOutUseCase,
  ) : super(EditUserDetailViewModel());

  UploadUserDataUsecase uploadUserDataUsecase;
  RemoveCurrentUserDataUsecase removeCurrentUserDataUsecase;
  LogOutUsecase logOutUseCase;

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      state.profileImage?.evict();

      state.profileImage = FileImage(File(pickedFile.path));
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
    if (state.profileImage == null) {
      return Future(() => left(const Failure('no-image-file')));
    }
    if (state.handle.isEmpty) {
      return Future(() => left(const Failure('no-handle')));
    }

    return await uploadUserDataUsecase(
      uid: state.uid,
      name: state.name,
      userImageFile: state.profileImage!.file,
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

  Future<void> downloadImageToFile(String imageUrl) async {
    state.profileImage?.evict();

    try {
      // HTTP GET 요청을 통해 이미지 데이터 다운로드
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // 애플리케이션의 문서 디렉토리에 파일 저장 경로 생성
        final documentDirectory = await getApplicationDocumentsDirectory();
        final filePath = '${documentDirectory.path}/downloaded_image.jpg';

        // 파일로 이미지 데이터 저장
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        state.profileImage = FileImage(file);
      } else {
        throw Exception('이미지 다운로드 실패: 상태 코드 ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('이미지 다운로드 중 오류 발생: $e');
    }
  }
}
