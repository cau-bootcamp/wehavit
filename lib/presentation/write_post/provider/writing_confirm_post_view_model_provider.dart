import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';

import 'package:wehavit/presentation/write_post/write_post.dart';

class WritingConfirmPostViewModelProvider
    extends StateNotifier<WritingConfirmPostViewModel> {
  WritingConfirmPostViewModelProvider() : super(WritingConfirmPostViewModel());

  int maxImagesCount = 3;

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
}
