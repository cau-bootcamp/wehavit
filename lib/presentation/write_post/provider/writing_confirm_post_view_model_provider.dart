import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

import 'package:wehavit/presentation/write_post/write_post.dart';

class WritingConfirmPostViewModelProvider
    extends StateNotifier<WritingConfirmPostViewModel> {
  WritingConfirmPostViewModelProvider(this._uploadConfirmPostUseCase)
      : super(WritingConfirmPostViewModel());

  final int maxImagesCount = 3;
  final UploadConfirmPostUseCase _uploadConfirmPostUseCase;

  Future<void> pickPhotos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> imageList = await picker.pickMultiImage(
      limit: maxImagesCount,
      requestFullMetadata: false,
    );

    state.imageMediaList = imageList;
  }

  Future<void> uploadPost({required bool hasRested}) async {
    _uploadConfirmPostUseCase(
      resolutionGoalStatement: state.entity?.goalStatement ?? '',
      resolutionId: state.entity?.resolutionId ?? '',
      content: state.postContent,
      localFileUrlList:
          state.imageMediaList.map((media) => media.path.toString()).toList(),
      hasRested: hasRested,
      isPostingForYesterday: state.isWritingYesterdayPost,
    );
  }
}
