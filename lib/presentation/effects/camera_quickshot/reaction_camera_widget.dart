import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class ReactionCameraWidget extends ConsumerStatefulWidget {
  const ReactionCameraWidget({
    super.key,
  });

  @override
  ConsumerState<ReactionCameraWidget> createState() => _ReactionCameraWidgetState();
}

class _ReactionCameraWidgetState extends ConsumerState<ReactionCameraWidget> {
  // late SwipeViewModelProvider _swipeViewModelProvider;

  @override
  Widget build(BuildContext context) {
    ReactionCameraWidgetModel model = ref.watch(reactionCameraWidgetModelProvider);
    ReactionCameraWidgetModelProvider provider = ref.read(reactionCameraWidgetModelProvider.notifier);

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(
                    model.isFocusingMode ? 0.7 : 0,
                  ),
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              final cameraController = ref.watch(
                reactionCameraWidgetModelProvider.select(
                  (model) => model.cameraController,
                ),
              );

              if (cameraController != null) {
                if (cameraController.value.previewSize != null) {
                  provider.initializeCameraWidgetSetting(context);

                  return Positioned(
                    top: model.cameraWidgetPositionY,
                    width: model.cameraWidgetRadius * 2,
                    height: model.cameraWidgetRadius * 2 * cameraController.value.aspectRatio,
                    child: RepaintBoundary(
                      key: model.repaintBoundaryGlobalKey,
                      child: IgnorePointer(
                        child: ValueListenableBuilder(
                          valueListenable: cameraPointerPositionNotifier,
                          builder: (context, value, child) {
                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  // 테두리 스타일 설정
                                  color: cameraPointerPositionNotifier.isPosInCapturingArea ? Colors.white : Colors.transparent, // 테두리 색상
                                  width: 4, // 테두리 두께
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4, // 테두리 두께
                                  ),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle, // 원 모양의 테두리 설정
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: CameraPreview(cameraController),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              }
              return Container();
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.transparent,
              height: 155,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
          ),
          Positioned(
            left: model.cameraButtonXOffset - model.cameraButtonRadius,
            top: model.cameraButtonYOffset - model.cameraButtonRadius,
            child: Container(
              width: model.cameraButtonRadius * 2,
              height: model.cameraButtonRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.isFocusingMode ? Colors.amber : Colors.transparent,
                // color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            top: 64,
            child: ValueListenableBuilder(
              valueListenable: cameraPointerPositionNotifier,
              builder: (context, value, child) {
                return Column(
                  children: [
                    Text(
                      cameraPointerPositionNotifier.isPosInCapturingArea
                          ? (model.isAddingPreset ? '손가락을 떼면 격려를 저장합니다\n📸 바로 지금! 📸' : '손가락을 떼면 격려가 전송됩니다\n📸 바로 지금! 📸')
                          : (model.isAddingPreset ? '아래로 손가락을 움직여\n당신의 사진을 남겨주세요' : '아래로 손가락을 움직여\n사진으로 격려를 남기세요'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 24,
                        color: CustomColors.whWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cameraPointerPositionNotifier.isPosInCapturingArea ? '' : '취소하려면 지금 손가락을 떼세요',
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: CustomColors.whWhite,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
