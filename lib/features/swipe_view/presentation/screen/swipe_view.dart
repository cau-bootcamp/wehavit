import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  double fromLeft = 0;
  double fromTop = 0;

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
      body: Stack(
        children: [
          SafeArea(
            child: _swipeViewModel.confirmPostModelList.fold(
              (failure) => Container(
                color: Colors.cyan,
              ),
              (modelList) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      height: 10,
                      color: Colors.blueGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List<Widget>.generate(
                          modelList.length,
                          (modelIndex) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                key: ValueKey(modelIndex),
                                decoration: BoxDecoration(
                                  color: _swipeViewModel.currentCellIndex ==
                                          modelIndex
                                      ? Colors.amber
                                      : Colors.grey[400],
                                ),
                                height: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            _swipeViewModelProvider.unfocusCommentTextForm(),
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
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_swipeViewModel.isCameraInitialized)
            ReactionCameraWidget(
              cameraController: _swipeViewModel.cameraController,
            ),
        ],
      ),
    );
  }

  Future<dynamic> emojiSheetWidget(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
      context: context,
      builder: (context) {
        void disposeWidget(UniqueKey key) {
          setState(() {
            _swipeViewModel.emojiWidgets.remove(key);
          });
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: _swipeViewModel.emojiWidgets.values.toList(),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        '반응을 ${_swipeViewModel.countSend}회 보냈어요!',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: List<Widget>.generate(
                          3,
                          (index) => Row(
                            children: List<Widget>.generate(5, (jndex) {
                              final key = UniqueKey();
                              return Expanded(
                                key: key,
                                child: GestureDetector(
                                  onTapDown: (detail) {},
                                  onTapUp: (detail) {
                                    shootEmoji(
                                      setState,
                                      index,
                                      jndex,
                                      detail,
                                      context,
                                      disposeWidget,
                                    );
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          Emojis.emojiList[index * 5 + jndex],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
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
}
