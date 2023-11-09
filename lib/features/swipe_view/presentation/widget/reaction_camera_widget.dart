import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';

class ReactionCameraWidget extends StatefulWidget {
  ReactionCameraWidget({super.key, required this.cameraController});

  CameraController cameraController;
  @override
  State<ReactionCameraWidget> createState() => _ReactionCameraWidgetState();
}

class _ReactionCameraWidgetState extends State<ReactionCameraWidget> {
  late GlobalKey repaintBoundaryGlobalKey;

  double cameraButtonOriginXOffset = 20;
  double cameraButtonOriginYOffset = 100;

  double cameraButtonXOffset = 20;
  double cameraButtonYOffset = 100;

  bool _isFocusingMode = false;

  bool get isFocusingMode => _isFocusingMode;
  set isFocusingMode(bool newValue) {
    if (newValue) {
      _cameraController.resumePreview();
    } else {
      _cameraController.pausePreview();
    }

    _isFocusingMode = newValue;
  }

  bool isShowingHelpMessage = false;

  late double screenWidth;
  late double screenHeight;

  late double cameraWidgetPositionX;
  late double cameraWidgetPositionY;
  late double cameraWidgetRadius;

  late CameraController _cameraController;

  bool isFingerInCameraArea(Point offset) {
    if (offset.distanceTo(Point(
            screenWidth / 2, cameraWidgetPositionY + cameraWidgetRadius)) <
        cameraWidgetRadius) {
      return true;
    }
    return false;
  }

  bool isCameraButtonPanned(Point offset) {
    if (offset.distanceTo(
            Point(cameraButtonOriginXOffset, cameraButtonOriginYOffset)) >=
        30) {
      return true;
    }
    return false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenWidth = View.of(context).physicalSize.width / 3;
    screenHeight = View.of(context).physicalSize.height / 3;

    cameraWidgetPositionX = screenWidth / 2;
    cameraWidgetPositionY = screenHeight / 2.5;
    cameraWidgetRadius = screenWidth / 3;
  }

  @override
  void initState() {
    super.initState();
    repaintBoundaryGlobalKey = GlobalKey();
    _cameraController = widget.cameraController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                    color:
                        Colors.black45.withOpacity(isFocusingMode ? 0.7 : 0)),
              ),
            ),
          ),
          Positioned(
            bottom: cameraWidgetPositionY,
            width: cameraWidgetRadius * 2,
            height:
                cameraWidgetRadius * 2 * _cameraController.value.aspectRatio,
            child: Opacity(
              opacity: isFocusingMode ? 0.7 : 0,
              child: RepaintBoundary(
                key: repaintBoundaryGlobalKey,
                child: IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CameraPreview(_cameraController),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: cameraButtonXOffset,
            bottom: cameraButtonYOffset,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowingHelpMessage = true;
                  Timer(Duration(seconds: 3), () {
                    isShowingHelpMessage = false;
                  });
                });
              },
              onTapDown: (details) {
                setState(() {
                  isFocusingMode = true;
                });
              },
              onTapUp: (details) {
                setState(() {
                  isFocusingMode = false;
                });
              },
              onLongPressEnd: (details) {
                setState(() {
                  isFocusingMode = false;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  isFocusingMode = true;
                  cameraButtonXOffset = cameraButtonXOffset - details.delta.dx;
                  cameraButtonYOffset = cameraButtonYOffset - details.delta.dy;
                });
              },
              onPanEnd: (details) async {
                if (isFingerInCameraArea(
                    Point(cameraButtonXOffset, cameraButtonYOffset))) {
                  // final fileImage = await cropSquare();
                  // final image = await getSquarePhotoImageFromCamera();
                  final fileImage = FileImage(File(await _capture()));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ImageSampleView(fileImage: fileImage)));
                }

                setState(() {
                  cameraButtonXOffset = cameraButtonOriginXOffset;
                  cameraButtonYOffset = cameraButtonOriginYOffset;
                  isFocusingMode = false;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFocusingMode ? Colors.amber : Colors.transparent,
                ),
                child: Text(
                  isFocusingMode ? '' : '📸',
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
        filePath, offsetX, offsetY, cropSize, cropSize);

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
      return "";
    }
  }
}

class ImageSampleView extends StatelessWidget {
  ImageSampleView({super.key, required this.fileImage});

  FileImage fileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Center(
              child: Image(
        image: fileImage,
      ))),
    );
  }
}
