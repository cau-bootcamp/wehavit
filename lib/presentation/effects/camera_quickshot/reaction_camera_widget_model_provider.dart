import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:wehavit/presentation/effects/effects.dart';

final showReactionCameraWidgetStateNotifier = ValueNotifier<bool>(
  false,
);

final cameraPointerPositionNotifier = CameraPointerPositionNotifier(const Offset(0, 0));

final reactionCameraWidgetModelProvider = StateNotifierProvider.autoDispose<ReactionCameraWidgetModelProvider, ReactionCameraWidgetModel>((ref) {
  final newModel = ReactionCameraWidgetModelProvider(ref);

  ref.listenSelf((_, __) {
    newModel._initializeCamera();
  });

  ref.onDispose(() {
    newModel._disposeCamera();
  });

  return newModel;
});

class ReactionCameraWidgetModelProvider extends StateNotifier<ReactionCameraWidgetModel> {
  ReactionCameraWidgetModelProvider(this.ref) : super(ReactionCameraWidgetModel());

  AutoDisposeStateNotifierProviderRef ref;

  Future<bool> _initializeCamera() async {
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
        return false;
      },
    );

    if (state.cameraController == null && description != null) {
      state.cameraController = CameraController(
        description,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await state.cameraController!.initialize();

      ref.notifyListeners();
      return true;
    }

    return false;
  }

  void updatePanPosition(Point<double> position) {
    state.isPosInCapturingArea = _checkPosInCapturingArea(position);
  }

  bool _checkPosInCapturingArea(Point<double> position) {
    if (state.screenHeight - position.y <= 150) {
      return true;
    }
    return false;
  }

  Future<void> _disposeCamera() async {
    state.cameraController?.dispose();
    state.cameraController = null;

    return;
  }

  void initializeCameraWidgetSetting(BuildContext context) {
    state.screenWidth = MediaQuery.of(context).size.width;
    state.screenHeight = MediaQuery.of(context).size.height;

    state.cameraWidgetPositionX = state.screenWidth / 2;
    state.cameraWidgetPositionY = state.screenHeight / 6;
    state.cameraWidgetRadius = state.screenWidth / 2.3;

    state.cameraButtonXOffset = state.cameraButtonOriginXOffset;
    state.cameraButtonYOffset = state.cameraButtonOriginYOffset;

    cameraPointerPositionNotifier.screenHeight = state.screenHeight;
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
    var renderObject = state.repaintBoundaryGlobalKey.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      File imgFile = File('$directory/screenshot${DateTime.now().toString()}.png');
      imgFile.writeAsBytes(pngBytes);

      return imgFile.path;
    } else {
      return '';
    }
  }
}
