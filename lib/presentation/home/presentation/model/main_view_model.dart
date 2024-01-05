import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/presentation/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';

class MainViewModel {
  // Carousel UI Variables
  CarouselController carouselController = CarouselController();
  int _currentCellIndex = 0;
  int get currentCellIndex => _currentCellIndex;
  set currentCellIndex(int newIndex) {
    countSend = 0;
    _currentCellIndex = newIndex;
    if (confirmPostModelList.isRight() &&
        confirmPostModelList
            .getRight()
            .fold(() => false, (list) => list.isNotEmpty)) {
      _currentCellConfirmPostModel = confirmPostModelList.foldRight(
        null,
        (acc, b) => b[_currentCellIndex],
      );
    }
  }

  Either<Failure, List<ConfirmPostEntity>> confirmPostModelList = right([]);
  List<Future<UserModel>> userModelList = [];

  ConfirmPostEntity? _currentCellConfirmPostModel;
  ConfirmPostEntity? get currentCellConfirmModel =>
      _currentCellConfirmPostModel;

  // Camera Reaction UI Variables
  late CameraController cameraController;
  bool isCameraInitialized = false;
  bool isCameraActivated = false;
  Offset cameraButtonPosition = const Offset(0, 0);

  // Emoji Reaction UI Variables
  Map<Key, ShootEmojiWidget> emojiWidgets = {};
  int countSend = 0;
  List<int> sendingEmojis = List<int>.generate(15, (index) => 0);

  // Text Reaction UI Variables
  TextEditingController textEditingController = TextEditingController();
  FocusNode commentFieldFocus = FocusNode();

  // Variables For View Layout Animation
  bool isLayoutGrowed = true;
  late AnimationController animationController;
  late Animation animation;

  // Varaibles For Graph
  List<Future<List<ConfirmPostEntity>>> confirmPostList = [];
}
