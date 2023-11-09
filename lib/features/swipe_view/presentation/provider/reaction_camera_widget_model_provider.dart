import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reactionCameraWidgetModelProvider = StateNotifierProvider<
    ReactionCameraWidgetModelProvider,
    ReactionCameraWidgetModel>((ref) => ReactionCameraWidgetModelProvider(ref));

class ReactionCameraWidgetModel {
  double cameraButtonOriginXOffset = 20;
  double cameraButtonOriginYOffset = 100;

  double cameraButtonXOffset = 20;
  double cameraButtonYOffset = 100;

  bool _isFocusingMode = false;

  bool isShowingHelpMessage = false;

  late double screenWidth;
  late double screenHeight;

  late double cameraWidgetPositionX;
  late double cameraWidgetPositionY;
  late double cameraWidgetRadius;

  late CameraController cameraController;
}

class ReactionCameraWidgetModelProvider
    extends StateNotifier<ReactionCameraWidgetModel> {
  ReactionCameraWidgetModelProvider(Ref ref)
      : super(ReactionCameraWidgetModel());

  bool get isFocusingMode => state._isFocusingMode;

  set isFocusingMode(bool newValue) {
    if (newValue) {
      state.cameraController.resumePreview();
    } else {
      state.cameraController.pausePreview();
    }
    state._isFocusingMode = newValue;
  }

  bool isFingerInCameraArea(Point offset) {
    if (offset.distanceTo(
          Point(
            state.screenWidth / 2,
            state.cameraWidgetPositionY + state.cameraWidgetRadius,
          ),
        ) <
        state.cameraWidgetRadius) {
      return true;
    }
    return false;
  }

  bool isCameraButtonPanned(Point offset) {
    if (offset.distanceTo(
          Point(
            state.cameraButtonOriginXOffset,
            state.cameraButtonOriginYOffset,
          ),
        ) >=
        30) {
      return true;
    }
    return false;
  }
}
