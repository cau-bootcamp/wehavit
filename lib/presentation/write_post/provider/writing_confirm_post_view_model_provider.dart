import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/utils/datetime+.dart';
import 'package:wehavit/common/utils/image_uploader.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

import 'package:wehavit/presentation/write_post/write_post.dart';

final writingConfirmPostViewModelProvider = StateNotifierProvider.autoDispose
    .family<WritingConfirmPostViewModelProvider, WritingConfirmPostViewModel, ResolutionEntity>((ref, entity) {
  return WritingConfirmPostViewModelProvider(ref, entity);
});

class WritingConfirmPostViewModelProvider extends StateNotifier<WritingConfirmPostViewModel> {
  WritingConfirmPostViewModelProvider(
    this.ref,
    resolutionEntity,
  ) : super(WritingConfirmPostViewModel(resolutionEntity));

  final Ref ref;

  final int maxImagesCount = 3;

  Future<void> pickPhotos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> imageList = await picker.pickMultiImage(
      limit: maxImagesCount,
      requestFullMetadata: false,
    );

    state.imageMediaList = imageList.getRange(0, min(imageList.length, 3)).map((imageFile) {
      return ImageUploadEntity(
        imageFile: imageFile,
        status: ImageUploadStatus.uploading,
      );
    }).toList();

    ref.notifyListeners();

    for (ImageUploadEntity entity in state.imageMediaList) {
      _uploadPhoto(entity).whenComplete(() {
        ref.notifyListeners();
      });
    }
  }

  Future<void> _uploadPhoto(ImageUploadEntity entity) {
    return ref.read(uploadConfirmPostImageUsecaseProvider).call(localImageFile: entity.imageFile).then((result) {
      final index = state.imageMediaList.indexWhere((e) => e.imageFile.name == entity.imageFile.name);
      if (index < 0) return;

      result.fold((failure) {
        state.imageMediaList[index].status = ImageUploadStatus.fail;
      }, (url) {
        state.imageMediaList[index].resultUrl = url;
        state.imageMediaList[index].status = ImageUploadStatus.success;
      });
    });
  }

  Future<void> reuploadPhoto(ImageUploadEntity entity) async {
    final index = state.imageMediaList.indexWhere((e) => e.imageFile.name == entity.imageFile.name);
    if (index < 0) return;

    state.imageMediaList[index].status = ImageUploadStatus.uploading;
    ref.notifyListeners();

    _uploadPhoto(state.imageMediaList[index]).whenComplete(() {
      ref.notifyListeners();
    });
  }

  void cancelPhotoUpload(ImageUploadEntity entity) {
    final index = state.imageMediaList.indexWhere((e) => e.imageFile.name == entity.imageFile.name);
    state.imageMediaList.removeAt(index);

    ref.notifyListeners();
  }

  Future<void> uploadPost({
    required bool hasRested,
    required UserDataEntity? myUserEntity,
  }) async {
    ref
        .read(uploadConfirmPostUseCaseProvider)
        .call(
          resolutionGoalStatement: state.entity.goalStatement,
          resolutionId: state.entity.resolutionId,
          content: state.postContent,
          fileUrlList: state.imageMediaList.map((e) => e.resultUrl).toList(),
          hasRested: hasRested,
          isPostingForYesterday: state.isWritingYesterdayPost,
        )
        .then(
      (result) async {
        final isPostingSuccess = result.fold((failure) => false, (value) => value);

        if (isPostingSuccess) {
          await sendNotiToSharedUsers(myUserEntity: myUserEntity);

          ref.invalidate(
            weeklyResolutionInfoProvider.call(
              WeeklyResolutionInfoProviderParam(
                resolutionId: state.entity.resolutionId,
                startMonday: DateTime.now().getMondayDateTime(),
              ),
            ),
          );
        }
      },
    );
  }

  void toggleYesterdayOption() {
    state.isWritingYesterdayPost = !state.isWritingYesterdayPost;
    ref.notifyListeners();
  }

  Future<void> sendNotiToSharedUsers({
    required UserDataEntity? myUserEntity,
  }) async {
    if (myUserEntity == null) {
      return;
    }

    ref.read(sendNotificationToSharedUsersUsecaseProvider).call(
          myUserEntity: myUserEntity,
          resolutionEntity: state.entity,
        );
  }
}
