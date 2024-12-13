import 'dart:core';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraPointerPositionNotifier extends ValueNotifier<Offset> {
  CameraPointerPositionNotifier(super.value);

  double? screenHeight;

  bool get isPosInCapturingArea {
    if (screenHeight == null) {
      AssertionError('need to init first');
      return false;
    }

    return screenHeight! - value.dy < 150;
  }
}

class ReactionCameraWidgetModel {
  GlobalKey repaintBoundaryGlobalKey = GlobalKey();

  double cameraButtonOriginXOffset = -100;
  double cameraButtonOriginYOffset = -100;

  double cameraButtonXOffset = 0;
  double cameraButtonYOffset = 0;
  double cameraButtonRadius = 25;

  bool isFocusingMode = false;
  bool isPosInCapturingArea = false;
  bool isShowingHelpMessage = false;

  double screenWidth = 0;
  double screenHeight = 0;

  double cameraWidgetPositionX = 0;
  double cameraWidgetPositionY = 0;
  double cameraWidgetRadius = 0;

  CameraController? cameraController;
  bool nonScrollMode = false;

  bool isAddingPreset = false;
}
