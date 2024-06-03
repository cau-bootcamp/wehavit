import 'dart:io';

class SignUpUserDataViewModel {
  String uid = '';
  File? profileImageFile;

  String name = '';
  String handle = '';
  String aboutMe = '';

  bool isProcessing = false;
}
