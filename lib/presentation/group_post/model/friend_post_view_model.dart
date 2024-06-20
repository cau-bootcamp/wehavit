import 'dart:math';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class FriendPostViewModel {
  //
  final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');

  CarouselController carouselController = CarouselController();
  ScrollController scrollController = ScrollController();

  bool isShowingCalendar = true;
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final todayDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  static final mondayOfThisWeek = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).subtract(Duration(days: DateTime.now().weekday - 1));

  String get selectedDateString => formatter.format(selectedDate);

  List<String> sharedResolutionIdList = [];
  Map<DateTime, EitherFuture<List<ConfirmPostEntity>>> confirmPostList = {};

  Point<double> panPosition = const Point<double>(0, 0);
  List<DateTime> calendartMondayDateList = [
    mondayOfThisWeek.subtract(const Duration(days: 7)),
    mondayOfThisWeek,
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

  late AnimationController animationController;
  late Animation animation;

  // Text Reaction UI Variables
  TextEditingController textEditingController = TextEditingController();
  FocusNode commentFieldFocus = FocusNode();
}
