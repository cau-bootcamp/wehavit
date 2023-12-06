import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/features/swipe_view/presentation/model/reaction_camera_widget_model.dart';
import 'package:wehavit/features/swipe_view/presentation/model/swipe_view_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/reaction_camera_widget_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/reaction_camera_widget.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/swipe_view_cell.dart';

class SwipeView extends ConsumerStatefulWidget {
  const SwipeView({super.key});

  @override
  ConsumerState<SwipeView> createState() {
    return SwipeViewState();
  }
}

class SwipeViewState extends ConsumerState<SwipeView>
    with SingleTickerProviderStateMixin {
  late final SwipeViewModel _swipeViewModel;
  late final SwipeViewModelProvider _swipeViewModelProvider;

  late final ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late final ReactionCameraWidgetModelProvider
      _reactionCameraWidgetModelProvider;

  bool _initOccurred = false;

  Point<double> panPosition = const Point(0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initOccurred) {
      _swipeViewModel = ref.watch(swipeViewModelProvider);
      _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);

      _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
      _reactionCameraWidgetModelProvider =
          ref.read(reactionCameraWidgetModelProvider.notifier);

      await ref
          .read(swipeViewModelProvider.notifier)
          .getTodayConfirmPostModelList();

      await _swipeViewModelProvider.initializeCamera();

      setAnimationVariables();

      setState(() {});
      _initOccurred = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColors.whDarkBlack,
              CustomColors.whYellow,
            ],
            stops: [0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Expanded(
          child: Stack(
            children: [
              SafeArea(
                left: false,
                right: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              // icon: Icon(Icons.arrow_back_ios),
                              icon: Icon(Icons.arrow_back_ios),
                              color: CustomColors.whWhite,
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                        Expanded(
                          child: _swipeViewModel.confirmPostModelList.fold(
                            (failure) => Container(
                              color: const Color.fromRGBO(0, 188, 212, 1),
                            ),
                            (modelList) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: modelList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _swipeViewModel
                                      .carouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            _swipeViewModel.currentCellIndex ==
                                                    entry.key
                                                ? CustomColors.whYellow
                                                : CustomColors.whSemiWhite),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: _swipeViewModel.confirmPostModelList.fold(
                        (failure) => Container(
                          color: const Color.fromRGBO(0, 188, 212, 1),
                        ),
                        (modelList) => Container(
                          constraints: BoxConstraints.expand(),
                          child: Expanded(
                            child: GestureDetector(
                              onTap: () => _swipeViewModelProvider
                                  .unfocusCommentTextForm(),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  height: MediaQuery.of(context).size.height,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _swipeViewModel.currentCellIndex = index;
                                    });
                                  },
                                  enableInfiniteScroll: false,
                                ),
                                carouselController:
                                    _swipeViewModel.carouselController,
                                items: List<Widget>.generate(
                                  modelList.length,
                                  (index) {
                                    return Flex(
                                      direction: Axis.vertical,
                                      children: [
                                        SwipeViewCellWidget(
                                          model: modelList[index],
                                          panUpdateCallback: updatePanPosition,
                                          panEndCallback:
                                              endOnCapturingPosition,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_swipeViewModel.isCameraInitialized)
                ReactionCameraWidget(
                  cameraController: _swipeViewModel.cameraController,
                  panPosition: panPosition,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void setAnimationVariables() {
    _swipeViewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _swipeViewModel.animation = Tween<double>(begin: 0, end: 130).animate(
      CurvedAnimation(
        parent: _swipeViewModel.animationController,
        curve: Curves.linear,
      ),
    );
    _swipeViewModel.animationController.value = 1;
  }

  void shootEmoji(
    StateSetter setState,
    int index,
    int jndex,
    TapUpDetails detail,
    BuildContext context,
    void Function(UniqueKey key) disposeWidget,
  ) {
    return setState(
      () {
        _swipeViewModel.countSend++;
        _swipeViewModel.sendingEmojis[index * 5 + jndex] += 1;
        final animationWidgetKey = UniqueKey();
        _swipeViewModel.emojiWidgets.addEntries(
          {
            animationWidgetKey: ShootEmojiWidget(
              key: animationWidgetKey,
              emojiIndex: index * 5 + jndex,
              currentPos:
                  Point(detail.globalPosition.dx, detail.globalPosition.dy),
              targetPos: Point(
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height + 50,
              ),
              disposeWidgetFromParent: disposeWidget,
            ),
          }.entries,
        );
      },
    );
  }

  void updatePanPosition(Point<double> position) {
    setState(() {
      panPosition = position;
    });
  }

  Future<void> endOnCapturingPosition(Point<double> position) async {
    final imageFilePath = await _reactionCameraWidgetModelProvider.capture();
    // 반응 전송 로직 아래에 삽입
    _swipeViewModelProvider.sendImageReaction(
      imageFilePath: imageFilePath,
    );
  }
}
