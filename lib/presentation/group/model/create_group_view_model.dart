import 'package:flutter/material.dart';

class CreateGroupViewModel {
  List<bool> stepDoneList = List<bool>.filled(4, false);
  ScrollController scrollController = ScrollController();

  String groupName = '';
  String groupDescription = '';
  String groupRule = '';
  int groupColorIndex = -1;
}
