import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/late_writing/domain/usecase/get_my_resolution_list_usecase.dart';
import 'package:wehavit/features/late_writing/presentation/model/late_writing_view_model.dart';
import 'package:wehavit/features/live_writing/live_writing.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:image_picker/image_picker.dart';

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
    final currentWritingResolutionModel = fetchResult
        .getRight()
        .fold(() => [], (t) => t)[state.resolutionIndex] as ResolutionModel;

    _createPostUseCase(
      ConfirmPostModel(
        resolutionGoalStatement: currentWritingResolutionModel.goalStatement,
        resolutionId: currentWritingResolutionModel.resolutionId,
        title: state.titleTextEditingController.text,
        content: state.contentTextEditingController.text,
        imageUrl: state.imageFileUrl ?? '',
        // TODO: OWNER, FAN, ResentStrike 넣어주는 로직 작성 필요함
        owner: '',
        fan: [],
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

  void getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state.imageFileUrl = pickedFile.path;
    } else {
      debugPrint('이미지 선택안함');
    }
  }
}
