import 'package:camera/camera.dart';

class ReactionCameraWidgetModel {
  double cameraButtonOriginXOffset = 20;
  double cameraButtonOriginYOffset = 100;

  double cameraButtonXOffset = 20;
  double cameraButtonYOffset = 100;

  bool isFocusingMode = false;

  bool isShowingHelpMessage = false;

  late double screenWidth;
  late double screenHeight;

  late double cameraWidgetPositionX;
  late double cameraWidgetPositionY;
  late double cameraWidgetRadius;

  late CameraController cameraController;
}
