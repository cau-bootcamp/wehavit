import 'package:image_picker/image_picker.dart';
import 'package:wehavit/domain/entities/entities.dart';

class WritingConfirmPostViewModel {
  ResolutionEntity? entity;
  DateTime todayDate = DateTime.now();
  bool isWritingYesterdayPost = false;
  String postContent = '';

  List<XFile> imageMediaList = [];
  bool isUploading = false;
}
