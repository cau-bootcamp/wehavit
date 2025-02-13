import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/utils/datetime+.dart';
import 'package:wehavit/common/utils/image_uploader.dart';
import 'package:wehavit/data/datasources/auth_social_datasource_impl.dart';
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

    final uploader = ImageUploader();

    state.imageMediaList = imageList.asMap().entries.map((entry) {
      return ImageUploadEntity(
        imageFile: entry.value,
        index: entry.key,
        status: ImageUploadStatus.uploading,
      );
    }).toList();

    ref.notifyListeners();

    for (ImageUploadEntity entity in state.imageMediaList) {
      uploader.uploadFile(entity).then((result) {
        state.imageMediaList[result.index].resultUrl = result.resultUrl;
        state.imageMediaList[result.index].status = result.status;
        ref.notifyListeners();
      });
    }
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
          localFileUrlList: state.imageMediaList.map((media) => media.imageFile.path.toString()).toList(),
          hasRested: hasRested,
          isPostingForYesterday: state.isWritingYesterdayPost,
        )
        .then(
      (result) {
        final isPostingSuccess = result.fold((failure) => false, (value) => value);

        if (isPostingSuccess) {
          ref.invalidate(
            weeklyResolutionInfoProvider.call(
              WeeklyResolutionInfoProviderParam(
                resolutionId: state.entity.resolutionId,
                startMonday: DateTime.now().getMondayDateTime(),
              ),
            ),
          );

          sendNotiToSharedUsers(myUserEntity: myUserEntity);
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
