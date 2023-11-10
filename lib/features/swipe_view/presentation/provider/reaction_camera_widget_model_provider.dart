import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/presentation/model/reaction_camera_widget_model.dart';

final reactionCameraWidgetModelProvider = StateNotifierProvider<
    ReactionCameraWidgetModelProvider,
    ReactionCameraWidgetModel>((ref) => ReactionCameraWidgetModelProvider(ref));

class ReactionCameraWidgetModelProvider
    extends StateNotifier<ReactionCameraWidgetModel> {
  ReactionCameraWidgetModelProvider(Ref ref)
      : super(ReactionCameraWidgetModel());

  bool get isFocusingMode => state.isFocusingMode;

  set isFocusingMode(bool newValue) {
    if (newValue) {
      state.cameraController.resumePreview();
    } else {
      state.cameraController.pausePreview();
    }
    state.isFocusingMode = newValue;
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
