import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/utils/image_uploader.dart';
import 'package:wehavit/domain/entities/entities.dart';

class WritingConfirmPostViewModel {
  WritingConfirmPostViewModel(this.entity);

  ResolutionEntity entity;
  DateTime todayDate = DateTime.now();
  bool isWritingYesterdayPost = false;
  String postContent = '';

  List<ImageUploadEntity> imageMediaList = [];

  bool isUploading = false;
}
