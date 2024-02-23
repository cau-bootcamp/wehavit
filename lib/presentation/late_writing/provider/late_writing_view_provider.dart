import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/late_writing/model/late_writing_view_model.dart';

class LateWritingViewModelProvider extends StateNotifier<LateWritingViewModel> {
  LateWritingViewModelProvider(
    this._createPostUseCase,
    this._getMyResolutionListUsecase,
  ) : super(LateWritingViewModel()) {
    // 팩토리 메서드 호출
    _initialize();
  }
  final UploadConfirmPostUseCase _createPostUseCase;
  final GetMyResolutionListUsecase _getMyResolutionListUsecase;

  // 비동기적으로 초기화를 진행하는 팩토리 메서드
  Future<void> _initialize() async {
    state.resolutionList = _getMyResolutionListUsecase(NoParams());
  }

  Future<void> postCurrentConfirmPost() async {
    final fetchResult = await state.resolutionList;
    final ResolutionEntity currentWritingResolutionModel = fetchResult
        .getRight()
        .fold(() => [], (t) => t)[state.resolutionIndex] as ResolutionEntity;

    _createPostUseCase(
      resolutionGoalStatement: currentWritingResolutionModel.goalStatement!,
      resolutionId: currentWritingResolutionModel.resolutionId!,
      title: state.titleTextEditingController.text,
      content: state.contentTextEditingController.text,
      imageUrl: state.imageFileUrl ?? '',
      // will be set in repository impl
      // fan: currentWritingResolutionModel.fanList!,
      attributes: {
        'has_participated_live': false,
        'has_rested': false,
      },
    );
  }

  Future<String?> getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      debugPrint('이미지 선택안함');
      return null;
    }
  }
}
