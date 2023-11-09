import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/reaction_camera_widget_model_provider.dart';

class ReactionCameraWidget extends ConsumerStatefulWidget {
  const ReactionCameraWidget({super.key, required this.cameraController});

  final CameraController cameraController;
  @override
  ConsumerState<ReactionCameraWidget> createState() =>
      _ReactionCameraWidgetState();
}

class _ReactionCameraWidgetState extends ConsumerState<ReactionCameraWidget> {
  late GlobalKey repaintBoundaryGlobalKey;
  late final ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late final ReactionCameraWidgetModelProvider
      _reactionCameraWidgetModelProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
    _reactionCameraWidgetModelProvider =
        ref.read(reactionCameraWidgetModelProvider.notifier);
    _reactionCameraWidgetModel.cameraController = widget.cameraController;

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
  }

  @override
  void initState() {
    super.initState();
    repaintBoundaryGlobalKey = GlobalKey();
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
                    _reactionCameraWidgetModelProvider.isFocusingMode ? 0.7 : 0,
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
              opacity:
                  _reactionCameraWidgetModelProvider.isFocusingMode ? 0.7 : 0,
              child: RepaintBoundary(
                key: repaintBoundaryGlobalKey,
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
            right: _reactionCameraWidgetModel.cameraButtonXOffset,
            bottom: _reactionCameraWidgetModel.cameraButtonYOffset,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _reactionCameraWidgetModel.isShowingHelpMessage = true;
                  Timer(const Duration(seconds: 3), () {
                    _reactionCameraWidgetModel.isShowingHelpMessage = false;
                  });
                });
              },
              onTapDown: (details) {
                setState(() {
                  _reactionCameraWidgetModelProvider.isFocusingMode = true;
                });
              },
              onTapUp: (details) {
                setState(() {
                  _reactionCameraWidgetModelProvider.isFocusingMode = false;
                });
              },
              onLongPressEnd: (details) {
                setState(() {
                  _reactionCameraWidgetModelProvider.isFocusingMode = false;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _reactionCameraWidgetModelProvider.isFocusingMode = true;
                  _reactionCameraWidgetModel.cameraButtonXOffset =
                      _reactionCameraWidgetModel.cameraButtonXOffset -
                          details.delta.dx;
                  _reactionCameraWidgetModel.cameraButtonYOffset =
                      _reactionCameraWidgetModel.cameraButtonYOffset -
                          details.delta.dy;
                });
              },
              onPanEnd: (details) async {
                if (_reactionCameraWidgetModelProvider.isFingerInCameraArea(
                  Point(
                    _reactionCameraWidgetModel.cameraButtonXOffset,
                    _reactionCameraWidgetModel.cameraButtonYOffset,
                  ),
                )) {
                  // final fileImage = await cropSquare();
                  // final image = await getSquarePhotoImageFromCamera();
                  final fileImage = FileImage(File(await _capture()));
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageSampleView(fileImage: fileImage),
                    ),
                  );
                }

                setState(() {
                  _reactionCameraWidgetModel.cameraButtonXOffset =
                      _reactionCameraWidgetModel.cameraButtonOriginXOffset;
                  _reactionCameraWidgetModel.cameraButtonYOffset =
                      _reactionCameraWidgetModel.cameraButtonOriginYOffset;
                  _reactionCameraWidgetModelProvider.isFocusingMode = false;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _reactionCameraWidgetModelProvider.isFocusingMode
                      ? Colors.amber
                      : Colors.transparent,
                ),
                child: Text(
                  _reactionCameraWidgetModelProvider.isFocusingMode ? '' : '📸',
                  style: const TextStyle(fontSize: 45),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<FileImage> cropSquare() async {
    final filePath = await _capture();

    // XFile? file = await _controller.takePicture();

    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(filePath);

    var cropSize = min(properties.width!, properties.height!);
    int offsetX = (properties.width! - cropSize) ~/ 2;
    int offsetY = (properties.height! - cropSize) ~/ 2;

    final imageFile = await FlutterNativeImage.cropImage(
      filePath,
      offsetX,
      offsetY,
      cropSize,
      cropSize,
    );

    return Future(() => FileImage(imageFile));
  }

  Future<String> _capture() async {
    var renderObject =
        repaintBoundaryGlobalKey.currentContext?.findRenderObject();
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

class ImageSampleView extends StatelessWidget {
  const ImageSampleView({super.key, required this.fileImage});

  final FileImage fileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image(
          image: fileImage,
        ),
      ),
    );
  }
}
