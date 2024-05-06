import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class ReactionCameraWidgetModel {
  GlobalKey repaintBoundaryGlobalKey = GlobalKey();

  double cameraButtonOriginXOffset = -100;
  double cameraButtonOriginYOffset = -100;

  double cameraButtonXOffset = 0;
  double cameraButtonYOffset = 0;
  double cameraButtonRadius = 25;

  bool isFocusingMode = false;

  bool isShowingHelpMessage = false;

  double screenWidth = 0;
  double screenHeight = 0;

  double cameraWidgetPositionX = 0;
  double cameraWidgetPositionY = 0;
  double cameraWidgetRadius = 0;

  CameraController? cameraController;

  // Point<double> panPosition = const Point<double>(0, 0);

  ReactionCameraWidgetModel copyWith({
    bool? isFocusingMode,
    Point<double>? currentButtonPosition,
  }) {
    final newModel = ReactionCameraWidgetModel();

    newModel.isFocusingMode = isFocusingMode ?? this.isFocusingMode;
    newModel.cameraButtonXOffset =
        currentButtonPosition?.x ?? cameraButtonXOffset;
    newModel.cameraButtonYOffset =
        currentButtonPosition?.y ?? cameraButtonYOffset;

    newModel.repaintBoundaryGlobalKey = repaintBoundaryGlobalKey;
    newModel.cameraButtonOriginXOffset = cameraButtonOriginXOffset;
    newModel.cameraButtonOriginYOffset = cameraButtonOriginYOffset;
    newModel.cameraButtonRadius = cameraButtonRadius;
    newModel.isShowingHelpMessage = isShowingHelpMessage;
    newModel.screenHeight = screenHeight;
    newModel.screenWidth = screenWidth;
    newModel.cameraWidgetPositionX = cameraButtonOriginXOffset;
    newModel.cameraWidgetPositionY = cameraWidgetPositionY;
    newModel.cameraWidgetRadius = cameraWidgetRadius;
    newModel.cameraController = cameraController;

    return newModel;
  }
}
