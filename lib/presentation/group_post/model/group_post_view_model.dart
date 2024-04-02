import 'dart:math';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class GroupPostViewModel {
  final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');

  CarouselController carouselController = CarouselController();
  ScrollController scrollController = ScrollController();

  String groupId = '';
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final todayDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  String get todayDateString => formatter.format(todayDate);

  Map<DateTime, List<ConfirmPostEntity>> confirmPostList = {};

  Point<double> panPosition = const Point<double>(0, 0);
  List<DateTime> calendartMondayDateList = [
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 7)),
  ];

  // Camera Reaction UI Variables
  CameraController? cameraController;
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
