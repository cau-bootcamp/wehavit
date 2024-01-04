import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/domain/entities/resolution_model.dart';
import 'package:wehavit/domain/usecases/confirm_post_usecase.dart';
import 'package:wehavit/domain/usecases/get_my_resolution_list_usecase.dart';
import 'package:wehavit/presentation/late_writing/presentation/model/late_writing_view_model.dart';
import 'package:wehavit/presentation/live_writing/live_writing.dart';

final lateWritingViewModelProvider =
    StateNotifierProvider<LateWritingViewModelProvider, LateWritingViewModel>(
  (ref) {
    final createPostUsecase = ref.watch(createPostUseCaseProvider);
    final getMyResolutionListUsecase =
        ref.watch(getMyResolutionListUsecaseProvider);

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
    state.resolutionList = _getMyResolutionListUsecase(NoParams());
  }

  final CreatePostUseCase _createPostUseCase;
  final GetMyResolutionListUsecase _getMyResolutionListUsecase;

  Future<void> postCurrentConfirmPost() async {
    final fetchResult = await state.resolutionList;
    final ResolutionModel currentWritingResolutionModel = fetchResult
        .getRight()
        .fold(() => [], (t) => t)[state.resolutionIndex] as ResolutionModel;

    _createPostUseCase(
      ConfirmPostModel(
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
