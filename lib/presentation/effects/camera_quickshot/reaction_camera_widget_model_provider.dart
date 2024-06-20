import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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

  Future<bool> initializeCamera() async {
    CameraDescription? description = await availableCameras().then(
      (cameras) {
        if (cameras.isEmpty) {
          return null;
        }

        return cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
        );
      },
      onError: (onError) {
        return Future(() => false);
      },
    );

    if (state.cameraController == null && description != null) {
      state.cameraController =
          CameraController(description, ResolutionPreset.medium);
      await state.cameraController!.initialize();

      return Future(() => true);
    }

    return Future(() => false);
  }

  void initializeCameraWidgetSetting(BuildContext context) {
    state.screenWidth = MediaQuery.of(context).size.width;
    state.screenHeight = MediaQuery.of(context).size.height;

    state.cameraWidgetPositionX = state.screenWidth / 2;
    state.cameraWidgetPositionY = state.screenHeight / 6;
    state.cameraWidgetRadius = state.screenWidth / 2.3;

    state.cameraButtonXOffset = state.cameraButtonOriginXOffset;
    state.cameraButtonYOffset = state.cameraButtonOriginYOffset;
  }

  Future<void> setFocusingModeTo(bool newValue) async {
    if (newValue) {
      state.cameraController?.resumePreview();
    } else {
      // 사용하지 않을 때는 멀리 치워놓기
      state.cameraButtonOriginXOffset = -100;
      state.cameraButtonOriginYOffset = -100;
      state.cameraController?.pausePreview();
    }

    state = state.copyWith(isFocusingMode: newValue);
  }

  void updatePanPosition(Point<double> position) {
    state = state.copyWith(
      currentButtonPosition: position,
      isPosInCapturingArea: checkPosInCapturingArea(position),
    );
  }

  bool checkPosInCapturingArea(Point<double> position) {
    if (state.screenHeight - position.y <= 150) {
      return true;
    }
    return false;
  }

  Future<String> endOnCapturingArea() async {
    final imageFilePath = await capture();
    return imageFilePath;
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
