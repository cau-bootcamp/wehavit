import 'package:flutter/material.dart';

class CreateGroupViewModel {
  List<bool> stepDoneList = List<bool>.filled(4, false);
  ScrollController scrollController = ScrollController();

  int focusedStep = 0;
  int currentStep = 0;

  List<bool> inputConditions = [false, false, false, true];

  bool get isMovableToNextStep =>
      inputConditions.sublist(0, currentStep + 1).reduce((value, element) => value & element);

  String groupName = '';
  String groupDescription = '';
  String groupRule = '';
  int groupColorIndex = 0;
}
