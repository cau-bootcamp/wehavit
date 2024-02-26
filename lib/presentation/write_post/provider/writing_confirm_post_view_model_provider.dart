import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

import 'package:wehavit/presentation/write_post/write_post.dart';

class WritingConfirmPostViewModelProvider
    extends StateNotifier<WritingConfirmPostViewModel> {
  WritingConfirmPostViewModelProvider(this._uploadConfirmPostUseCase)
      : super(WritingConfirmPostViewModel());

  final int maxImagesCount = 3;
  final UploadConfirmPostUseCase _uploadConfirmPostUseCase;

  Future<void> pickPhotos() async {
    List<Media>? photosList = [];
    photosList = await ImagesPicker.pick(
      count: maxImagesCount,
      pickType: PickType.all,
      cropOpt: CropOption(
        aspectRatio: const CropAspectRatio(600, 400),
      ),
    );
    state.imageMediaList = photosList ?? [];
  }

  Future<void> uploadPost() async {
    _uploadConfirmPostUseCase(
      resolutionGoalStatement: state.entity?.goalStatement ?? '',
      resolutionId: state.entity?.resolutionId ?? '',
      content: state.postContent,
      localFileUrlList:
          state.imageMediaList.map((media) => media.path.toString()).toList(),
      hasRested: false,
    );
  }
}
