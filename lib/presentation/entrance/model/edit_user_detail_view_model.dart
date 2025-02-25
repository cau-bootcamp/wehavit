import 'package:flutter/widgets.dart';

class EditUserDataViewAction {}

class EditUserDataViewNoDataAction extends EditUserDataViewAction {}

class EditUserDataViewSetDataAction extends EditUserDataViewAction {
  EditUserDataViewSetDataAction(this.name, this.handle, this.aboutMe, this.profileImagUrl);

  String name;
  String handle;
  String aboutMe;
  String profileImagUrl;
}

class EditUserDetailViewModel {
  FileImage? profileImage;

  String name = '';
  String handle = '';
  String aboutMe = '';

  bool isProcessing = false;
}
