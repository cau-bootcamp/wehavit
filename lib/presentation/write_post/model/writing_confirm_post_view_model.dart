import 'package:images_picker/images_picker.dart';
import 'package:wehavit/domain/entities/entities.dart';

class WritingConfirmPostViewModel {
  ResolutionEntity? entity;
  DateTime todayDate = DateTime.now();
  bool isWritingYesterdayPost = false;
  String postContent = '';

  List<Media> imageMediaList = [];
}
