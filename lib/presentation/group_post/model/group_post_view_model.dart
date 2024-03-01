import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class GroupPostViewModel {
  CarouselController carouselController = CarouselController();

  // Camera Reaction UI Variables
  late CameraController cameraController;
  bool isCameraInitialized = false;
  bool isCameraActivated = false;
  bool isFocusingMode = false;
  Offset cameraButtonPosition = const Offset(0, 0);

  // Emoji Reaction UI Variables
  Map<Key, ShootEmojiWidget> emojiWidgets = {};
  int countSend = 0;
  List<int> sendingEmojis = List<int>.generate(15, (index) => 0);

  // Text Reaction UI Variables
  TextEditingController textEditingController = TextEditingController();
  FocusNode commentFieldFocus = FocusNode();
}
