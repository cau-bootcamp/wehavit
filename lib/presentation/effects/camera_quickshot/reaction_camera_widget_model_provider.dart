import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/presentation/effects/effects.dart';

final reactionCameraWidgetModelProvider = StateNotifierProvider<
    ReactionCameraWidgetModelProvider,
    ReactionCameraWidgetModel>((ref) => ReactionCameraWidgetModelProvider(ref));

class ReactionCameraWidgetModelProvider
    extends StateNotifier<ReactionCameraWidgetModel> {
  ReactionCameraWidgetModelProvider(Ref ref)
      : super(ReactionCameraWidgetModel());

  void updateCameraControllerWith(CameraController cameraController) {
    state = state.copyWith(cameraController: cameraController);
  }

  void setFocusingModeTo(bool newValue) {
    if (newValue) {
      state.cameraController!.resumePreview();
    } else {
      // 사용하지 않을 때는 멀리 치워놓기
      state.cameraButtonOriginXOffset = -100;
      state.cameraButtonOriginYOffset = -100;
      state.cameraController!.pausePreview();
    }
    state = state.copyWith(isFocusingMode: newValue);
  }

  bool isPosInCameraAreaOf(Point<double> pos) {
    if (Point(pos.x, pos.y).distanceTo(
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

  Future<String> capture() async {
    var renderObject =
        state.repaintBoundaryGlobalKey.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      File imgFile =
          File('$directory/screenshot${DateTime.now().toString()}.png');
      imgFile.writeAsBytes(pngBytes);

      return imgFile.path;
    } else {
      return '';
    }
  }
}
