import 'dart:core';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraPointerPositionNotifier extends ValueNotifier<Offset> {
  CameraPointerPositionNotifier(super._value);

  double? screenHeight;

  bool get isPosInCapturingArea {
    if (screenHeight == null) {
      AssertionError('Need to call initializeCameraWidgetSetting first');
      return false;
    }

    return screenHeight! - value.dy < 150;
  }
}

enum ReactionCameraWidgetMode {
  quickshot,
  preset,
  none;
}

class ReactionCameraWidgetModel {
  GlobalKey repaintBoundaryGlobalKey = GlobalKey();

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

  bool isAddingPreset = false;
}
