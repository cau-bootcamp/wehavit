import 'dart:math';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class ReactionCameraWidget extends ConsumerStatefulWidget {
  ReactionCameraWidget({
    super.key,
    required this.cameraController,
    required this.panPosition,
  });

  final CameraController cameraController;
  Point<double> panPosition;

  @override
  ConsumerState<ReactionCameraWidget> createState() =>
      _ReactionCameraWidgetState();
}

class _ReactionCameraWidgetState extends ConsumerState<ReactionCameraWidget> {
  late ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late ReactionCameraWidgetModelProvider _reactionCameraWidgetModelProvider;
  // late SwipeViewModelProvider _swipeViewModelProvider;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    _reactionCameraWidgetModelProvider
        .updateCameraControllerWith(widget.cameraController);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
    _reactionCameraWidgetModelProvider =
        ref.read(reactionCameraWidgetModelProvider.notifier);

    _reactionCameraWidgetModel.cameraController = widget.cameraController;
    // _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);

    _reactionCameraWidgetModel.screenWidth = MediaQuery.of(context).size.width;
    _reactionCameraWidgetModel.screenHeight =
        MediaQuery.of(context).size.height;

    _reactionCameraWidgetModel.cameraWidgetPositionX =
        _reactionCameraWidgetModel.screenWidth / 2;
    _reactionCameraWidgetModel.cameraWidgetPositionY =
        _reactionCameraWidgetModel.screenHeight / 6;
    _reactionCameraWidgetModel.cameraWidgetRadius =
        _reactionCameraWidgetModel.screenWidth / 2.3;

    _reactionCameraWidgetModel.cameraButtonXOffset =
        _reactionCameraWidgetModel.cameraButtonOriginXOffset;
    _reactionCameraWidgetModel.cameraButtonYOffset =
        _reactionCameraWidgetModel.cameraButtonOriginYOffset;

    return Visibility(
      visible: _reactionCameraWidgetModel.isFocusingMode,
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: IgnorePointer(
                child: Container(
                  child: new BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black45.withOpacity(
                      _reactionCameraWidgetModel.isFocusingMode ? 0.7 : 0,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              child: Text(
                '아래로 손가락을 움직여\n사진으로 격려를 남기세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: CustomColors.whWhite,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              top: _reactionCameraWidgetModel.cameraWidgetPositionY,
              width: _reactionCameraWidgetModel.cameraWidgetRadius * 2,
              height: _reactionCameraWidgetModel.cameraWidgetRadius *
                  2 *
                  widget.cameraController.value.aspectRatio,
              child: Opacity(
                opacity: _reactionCameraWidgetModel.isFocusingMode ? 1 : 0,
                child: RepaintBoundary(
                  key: _reactionCameraWidgetModel.repaintBoundaryGlobalKey,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          // 테두리 스타일 설정
                          color: Colors.white, // 테두리 색상
                          width: 4, // 테두리 두께
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            // 테두리 스타일 설정
                            color: Colors.black, // 테두리 색상
                            width: 4, // 테두리 두께
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle, // 원 모양의 테두리 설정
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CameraPreview(
                            widget.cameraController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: widget.panPosition.x -
                  _reactionCameraWidgetModel.cameraButtonRadius,
              top: widget.panPosition.y -
                  _reactionCameraWidgetModel.cameraButtonRadius,
              child: Container(
                width: _reactionCameraWidgetModel.cameraButtonRadius * 2,
                height: _reactionCameraWidgetModel.cameraButtonRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _reactionCameraWidgetModel.isFocusingMode
                      ? Colors.amber
                      : Colors.transparent,
                  // color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              left: 0,
              top: _reactionCameraWidgetModel.cameraWidgetPositionY +
                  _reactionCameraWidgetModel.cameraWidgetRadius * 2 +
                  100,
              child: Text(
                '취소하려면 지금 손가락을 떼세요',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: CustomColors.whWhite,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                child: Container(
                  color: Colors.transparent,
                  height: 155,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: CurvePainter(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [
          CustomColors.whYellowDark,
          const ui.Color.fromARGB(255, 39, 28, 0),
        ],
      );
    // paint.color = Color(0XFF382b47);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.26);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height * 0.26,
    );
    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
