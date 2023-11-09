import 'dart:math';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/widget/reaction_camera_widget.dart';
import 'package:wehavit/features/swipe_view/presentation/widget/swipe_view_cell.dart';

class SwipeView extends ConsumerStatefulWidget {
  const SwipeView({super.key});
  // CameraController cameraController;

  @override
  ConsumerState<SwipeView> createState() {
    return SwipeViewState();
  }
}

class SwipeViewState extends ConsumerState<SwipeView> {
  late final SwipeViewModel swipeViewModel;

  // Camera View Properties
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    swipeViewModel = ref.watch(swipeViewModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref
              .read(swipeViewModelProvider.notifier)
              .getTodayConfirmPostModelList();
          setState(() {});
        },
      ),
      body: Stack(
        children: [
          SafeArea(
            child: swipeViewModel.confirmPostModelList.fold(
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
                                  color: swipeViewModel.currentCellNumber ==
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
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: MediaQuery.of(context).size.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              swipeViewModel.currentCellNumber = index;
                            });
                          },
                          enableInfiniteScroll: false,
                        ),
                        carouselController: swipeViewModel.carouselController,
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            GestureDetector(
                              onTapUp: (details) async =>
                                  emojiSheetWidget(context)
                                      .whenComplete(() async {
                                swipeViewModel.emojiWidgets.clear();

                                if (swipeViewModel.sendingEmojis
                                    .any((element) => element > 0)) {
                                  final Map<String, int> emojiMap = {};
                                  swipeViewModel.sendingEmojis.asMap().forEach(
                                        (index, value) => emojiMap.addAll(
                                          {'t$index': value},
                                        ),
                                      );

                                  final reactionModel = ReactionModel(
                                    complementerUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    reactionType: ReactionType.emoji.index,
                                    emoji: emojiMap,
                                  );

                                  ref
                                      .read(swipeViewModelProvider.notifier)
                                      .sendReactionToTargetConfirmPost(
                                        modelList[swipeViewModel
                                                .currentCellNumber]
                                            .id!,
                                        reactionModel,
                                      );

                                  swipeViewModel.sendingEmojis =
                                      List<int>.generate(15, (index) => 0);
                                }
                              }),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.black,
                                ),
                                child: const Center(
                                  child: Text(
                                    '😄',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: initializeCamera(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return ReactionCameraWidget(
                    cameraController: swipeViewModel.cameraController,
                  );
                }
              }
              return Container();
            },
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
            swipeViewModel.emojiWidgets.remove(key);
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
                  children: swipeViewModel.emojiWidgets.values.toList(),
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
                        '반응을 ${swipeViewModel.countSend}회 보냈어요!',
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
                              final key = GlobalKey();
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
        swipeViewModel.countSend++;
        swipeViewModel.sendingEmojis[index * 5 + jndex] += 1;
        final animationWidgetKey = UniqueKey();
        swipeViewModel.emojiWidgets.addEntries(
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

  Future<bool> initializeCamera() async {
    CameraDescription description = await availableCameras().then(
      (cameras) => cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      ),
    );
    if (!_isCameraInitialized) {
      swipeViewModel.cameraController =
          CameraController(description, ResolutionPreset.medium);

      await swipeViewModel.cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }

    return Future(() => true);
  }
}

class ShootEmojiWidget extends StatefulWidget {
  ShootEmojiWidget({
    super.key,
    required this.disposeWidgetFromParent,
    required this.currentPos,
    required this.targetPos,
    required this.emojiIndex,
  });
  int emojiIndex;
  Function disposeWidgetFromParent;
  Point currentPos;
  Point targetPos;

  @override
  State<ShootEmojiWidget> createState() => _ShootEmojiWidgetState();
}

class _ShootEmojiWidgetState extends State<ShootEmojiWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _yAnimation, _xAnimation;
  late Function disposeWidgetFromParent;
  late double targetXPos;
  final double emojiSize = 50;

  @override
  void initState() {
    super.initState();

    disposeWidgetFromParent = widget.disposeWidgetFromParent;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _yAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _xAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward(from: 0.0);
    _controller.addListener(
      () {
        if (mounted) {
          setState(() {});
        }
      },
    );
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          disposeWidgetFromParent(widget.key);
          // dispose();
          // super.dispose();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (widget.targetPos.y * 1.0 * _yAnimation.value) +
          (400) * (1 - _yAnimation.value),
      left: widget.targetPos.x.toDouble() * _xAnimation.value +
          (widget.currentPos.x.toDouble()) * (1 - _xAnimation.value) -
          emojiSize / 2,
      child: Opacity(
        opacity: _controller.status == AnimationStatus.completed ? 0.0 : 1.0,
        child: Image(
          width: emojiSize,
          height: emojiSize,
          image: AssetImage(
            Emojis.emojiList[widget.emojiIndex],
          ),
        ),
      ),
    );
  }
}
