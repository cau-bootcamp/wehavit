import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';

class SwipeViewModel {
  // Carousel UI Variables
  CarouselController carouselController = CarouselController();
  int _currentCellIndex = 0;
  int get currentCellIndex => _currentCellIndex;
  set currentCellIndex(int newIndex) {
    _currentCellIndex = newIndex;
    _currentCellConfirmPostModel =
        confirmPostModelList.foldRight(null, (acc, b) => b[_currentCellIndex]);
  }

  Either<Failure, List<ConfirmPostModel>> confirmPostModelList = right([]);
  List<Future<UserModel>> userModelList = [];

  ConfirmPostModel? _currentCellConfirmPostModel;
  ConfirmPostModel? get currentCellConfirmModel => _currentCellConfirmPostModel;

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
  List<Future<List<ConfirmPostModel>>> confirmPostList = [];
}
