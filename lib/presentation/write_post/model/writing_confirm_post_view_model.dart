import 'package:wehavit/common/utils/image_uploader.dart';
import 'package:wehavit/domain/entities/entities.dart';

class WritingConfirmPostViewModel {
  WritingConfirmPostViewModel(this.entity);

  ResolutionEntity entity;

  DateTime todayDate = DateTime.now();

  bool isUploading = false;
  bool isWritingYesterdayPost = false;

  String postContent = '';
  List<ImageUploadEntity> imageMediaList = [];
}
