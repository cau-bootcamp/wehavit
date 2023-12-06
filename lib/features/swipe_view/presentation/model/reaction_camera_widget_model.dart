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

  late double screenWidth;
  late double screenHeight;

  late double cameraWidgetPositionX;
  late double cameraWidgetPositionY;
  late double cameraWidgetRadius;

  late CameraController cameraController;
}
