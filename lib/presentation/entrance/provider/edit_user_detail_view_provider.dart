import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';

import 'package:wehavit/presentation/entrance/entrance.dart';

final editUserDataViewActionProvider = StateProvider<EditUserDataViewAction>(
  (ref) => EditUserDataViewAction(),
);

final editUserDataViewModelProvider = StateNotifierProvider.autoDispose
    .family<EditUserDataViewModelProvider, EditUserDetailViewModel, String>((ref, userId) {
  final viewModel = EditUserDataViewModelProvider(ref, userId);

  ref.listenSelf((_, next) {
    // 필요할 경우 로직 추가
  });

  return viewModel;

  // return EditUserDataViewModelProvider(ref, userId);
});

class EditUserDataViewModelProvider extends StateNotifier<EditUserDetailViewModel> {
  EditUserDataViewModelProvider(
    this.ref,
    this.userId,
  ) : super(EditUserDetailViewModel()) {
    unawaited(
      ref.read(getUserDataFromIdUsecaseProvider).call(userId).then(
            (result) => result.fold((failure) {
              ref.read(editUserDataViewActionProvider.notifier).update((_) => EditUserDataViewNoDataAction());
            }, (entity) {
              ref.read(editUserDataViewActionProvider.notifier).update(
                    (_) => EditUserDataViewSetDataAction(
                      entity.userName,
                      entity.handle,
                      entity.aboutMe,
                      entity.userImageUrl,
                    ),
                  );
            }),
          ),
    );
  }

  Ref ref;
  String userId;

  static const int nameMinLength = 4;
  static const int nameMaxLength = 16;
  static const int handleMinLength = 1;
  static const int handleMaxLength = 16;
  static const int aboutMeMinLength = 0;
  static const int aboutMeMaxLength = 20;

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedFile != null) {
      state.profileImage?.evict();

      state.profileImage = FileImage(File(pickedFile.path));
    }
    ref.notifyListeners();
  }

  void setName(String value) {
    state.name = value;
    ref.notifyListeners();
  }

  void setHandle(String value) {
    state.handle = value;
    ref.notifyListeners();
  }

  void setAboutMe(String value) {
    state.aboutMe = value;
    ref.notifyListeners();
  }

  EitherFuture<void> registerUserData() async {
    if (state.profileImage == null) {
      return Future(() => left(const Failure('no-image-file')));
    }
    if (state.handle.isEmpty) {
      return Future(() => left(const Failure('no-handle')));
    }

    return await ref
        .read(uploadUserDataUsecaseProvider)(
      uid: userId,
      name: state.name,
      userImageFile: state.profileImage!.file,
      aboutMe: state.aboutMe,
      handle: state.handle,
    )
        .then((result) {
      return result.fold(
        (failure) => left(failure),
        (success) => right(null),
      );
    });
  }

  Future<void> rollbackSignUp() async {
    _removeUserData();
    _logOut();
  }

  EitherFuture<void> _removeUserData() async {
    return ref.read(removeCurrentUserDataUsecaseProvider).call();
  }

  Future<void> _logOut() {
    return ref.read(logOutUseCaseProvider).call();
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
        ref.notifyListeners();
      } else {
        throw Exception('이미지 다운로드 실패: 상태 코드 ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('이미지 다운로드 중 오류 발생: $e');
    }
  }
}
