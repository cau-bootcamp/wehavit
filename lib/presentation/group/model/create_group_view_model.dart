import 'package:flutter/material.dart';

class CreateGroupViewModel {
  List<bool> stepDoneList = List<bool>.filled(4, false);
  ScrollController scrollController = ScrollController();

  int focusedStep = 0;
  int currentStep = 0;
  bool isMovableToNextStep = false;
  List<bool> inputConditions = [false, false, false, true];

  String groupName = '';
  String groupDescription = '';
  String groupRule = '';
  int groupColorIndex = 0;
}
