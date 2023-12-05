import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/presentation/model/reaction_camera_widget_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/reaction_camera_widget_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';

class ReactionCameraWidget extends ConsumerStatefulWidget {
  const ReactionCameraWidget({
    super.key,
    required this.cameraController,
  });

  final CameraController cameraController;

  @override
  ConsumerState<ReactionCameraWidget> createState() =>
      _ReactionCameraWidgetState();
}

class _ReactionCameraWidgetState extends ConsumerState<ReactionCameraWidget> {
  late final ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late final ReactionCameraWidgetModelProvider
      _reactionCameraWidgetModelProvider;
  late final SwipeViewModelProvider _swipeViewModelProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
    _reactionCameraWidgetModelProvider =
        ref.read(reactionCameraWidgetModelProvider.notifier);
    _reactionCameraWidgetModel.cameraController = widget.cameraController;
    _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);

    _reactionCameraWidgetModel.screenWidth =
        View.of(context).physicalSize.width / 3;
    _reactionCameraWidgetModel.screenHeight =
        View.of(context).physicalSize.height / 3;

    _reactionCameraWidgetModel.cameraWidgetPositionX =
        _reactionCameraWidgetModel.screenWidth / 2;
    _reactionCameraWidgetModel.cameraWidgetPositionY =
        _reactionCameraWidgetModel.screenHeight / 3;
    _reactionCameraWidgetModel.cameraWidgetRadius =
        _reactionCameraWidgetModel.screenWidth / 2.3;

    _reactionCameraWidgetModel.cameraButtonXOffset =
        _reactionCameraWidgetModel.cameraButtonOriginXOffset;
    _reactionCameraWidgetModel.cameraButtonYOffset =
        _reactionCameraWidgetModel.cameraButtonOriginYOffset;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    _reactionCameraWidgetModel.isFocusingMode ? 0.7 : 0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: _reactionCameraWidgetModel.cameraWidgetPositionY,
            width: _reactionCameraWidgetModel.cameraWidgetRadius * 2,
            height: _reactionCameraWidgetModel.cameraWidgetRadius *
                2 *
                _reactionCameraWidgetModel.cameraController.value.aspectRatio,
            child: Opacity(
              opacity: _reactionCameraWidgetModel.isFocusingMode ? 1 : 0,
              child: RepaintBoundary(
                key: _reactionCameraWidgetModel.repaintBoundaryGlobalKey,
                child: IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CameraPreview(
                      _reactionCameraWidgetModel.cameraController,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: _reactionCameraWidgetModel.cameraButtonXOffset -
                _reactionCameraWidgetModel.cameraButtonRadius,
            top: _reactionCameraWidgetModel.cameraButtonYOffset -
                _reactionCameraWidgetModel.cameraButtonRadius,
            child: Container(
              width: _reactionCameraWidgetModel.cameraButtonRadius * 2,
              height: _reactionCameraWidgetModel.cameraButtonRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _reactionCameraWidgetModel.isFocusingMode
                    ? Colors.amber
                    : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
