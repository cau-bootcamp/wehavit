import 'package:images_picker/images_picker.dart';

class WritingConfirmPostViewModel {
  DateTime todayDate = DateTime.now();
  bool isWritingYesterdayPost = false;
  String postContent = '';

  List<Media> imageMediaList = [];
}
