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

  double screenWidth = 300;
  double screenHeight = 800;

  double cameraWidgetPositionX = 100;
  double cameraWidgetPositionY = 100;
  double cameraWidgetRadius = 50;

  CameraController? cameraController;

  ReactionCameraWidgetModel copyWith(
      {bool? isFocusingMode, CameraController? cameraController}) {
    var newModel = ReactionCameraWidgetModel();
    newModel.isFocusingMode = isFocusingMode ?? newModel.isFocusingMode;
    newModel.cameraController = cameraController ?? newModel.cameraController;
    return newModel;
  }
}
