import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/utils/datetime+.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

import 'package:wehavit/presentation/write_post/write_post.dart';

class WritingConfirmPostViewModelProvider extends StateNotifier<WritingConfirmPostViewModel> {
  WritingConfirmPostViewModelProvider(
    this.ref,
    this._uploadConfirmPostUseCase,
    this._sendNotificationToSharedUsersUsecase,
  ) : super(WritingConfirmPostViewModel());

  final int maxImagesCount = 3;
  final Ref ref;
  final UploadConfirmPostUseCase _uploadConfirmPostUseCase;
  final SendNotificationToSharedUsersUsecase _sendNotificationToSharedUsersUsecase;

  Future<void> pickPhotos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> imageList = await picker.pickMultiImage(
      limit: maxImagesCount,
      requestFullMetadata: false,
    );

    state.imageMediaList = imageList;
  }

  Future<void> uploadPost({
    required bool hasRested,
    required UserDataEntity? myUserEntity,
  }) async {
    _uploadConfirmPostUseCase(
      resolutionGoalStatement: state.entity?.goalStatement ?? '',
      resolutionId: state.entity?.resolutionId ?? '',
      content: state.postContent,
      localFileUrlList: state.imageMediaList.map((media) => media.path.toString()).toList(),
      hasRested: hasRested,
      isPostingForYesterday: state.isWritingYesterdayPost,
    ).then(
      (result) {
        final isPostingSuccess = result.fold((failure) => false, (value) => value);

        if (isPostingSuccess) {
          ref.invalidate(
            weeklyResolutionInfoProvider.call(
              WeeklyResolutionInfoProviderParam(
                resolutionId: state.entity!.resolutionId,
                startMonday: DateTime.now().getMondayDateTime(),
              ),
            ),
          );

          sendNotiToSharedUsers(myUserEntity: myUserEntity);
        }
      },
    );
  }

  Future<void> sendNotiToSharedUsers({
    required UserDataEntity? myUserEntity,
  }) async {
    if (state.entity == null || myUserEntity == null) {
      return;
    }

    _sendNotificationToSharedUsersUsecase(
      myUserEntity: myUserEntity,
      resolutionEntity: state.entity!,
    );
  }
}
