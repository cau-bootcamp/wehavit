import 'dart:io';

class EditUserDetailViewModel {
  String uid = '';
  File? profileImageFile;

  String name = '';
  String handle = '';
  String aboutMe = '';

  bool isProcessing = false;
}
