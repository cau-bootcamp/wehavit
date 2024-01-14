import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/usecases/get_resolution_list_usecase.dart';
import 'package:wehavit/domain/usecases/upload_confirm_post_usecase.dart';
import 'package:wehavit/presentation/late_writing/model/late_writing_view_model.dart';

final lateWritingViewModelProvider =
    StateNotifierProvider<LateWritingViewModelProvider, LateWritingViewModel>(
  (ref) {
    final createPostUsecase = ref.watch(uploadConfirmPostUseCaseProvider);
    final getMyResolutionListUsecase =
        ref.watch(getResolutionListByUserIdUsecaseProvider);

    return LateWritingViewModelProvider(
      createPostUsecase,
      getMyResolutionListUsecase,
    );
  },
);

class LateWritingViewModelProvider extends StateNotifier<LateWritingViewModel> {
  LateWritingViewModelProvider(
    this._createPostUseCase,
    this._getMyResolutionListUsecase,
  ) : super(LateWritingViewModel()) {
    // TODO: 자신의 resolution list를 받아오는 코드 작성하기
    // state.resolutionList = _getMyResolutionListUsecase(NoParams());
  }

  final UploadConfirmPostUseCase _createPostUseCase;
  final GetResolutionListByUserIdUsecase _getMyResolutionListUsecase;

  Future<void> postCurrentConfirmPost() async {
    final fetchResult = await state.resolutionList;
    final ResolutionEntity currentWritingResolutionModel = fetchResult
        .getRight()
        .fold(() => [], (t) => t)[state.resolutionIndex] as ResolutionEntity;

    _createPostUseCase(
      ConfirmPostEntity(
        resolutionGoalStatement: currentWritingResolutionModel.goalStatement,
        resolutionId: currentWritingResolutionModel.resolutionId,
        title: state.titleTextEditingController.text,
        content: state.contentTextEditingController.text,
        imageUrl: state.imageFileUrl ?? '',
        // will be set in repository impl
        owner: '',
        fan: currentWritingResolutionModel.fanList,
        recentStrike: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        attributes: {
          'has_participated_live': false,
          'has_rested': false,
        },
      ),
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
