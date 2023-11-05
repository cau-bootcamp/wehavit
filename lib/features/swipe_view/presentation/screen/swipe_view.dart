import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/data/enitty/DEBUG_confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/widget/swipe_view_cell.dart';

class SwipeView extends ConsumerStatefulWidget {
  SwipeView({super.key});

  @override
  ConsumerState<SwipeView> createState() {
    // TODO: implement createState
    return SwipeViewState();
  }
}

class SwipeViewState extends ConsumerState<SwipeView> {
  int _currentCellNumber = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    var swipeViewProviderList = ref.watch(swipeViewProvider);
    Map<Key, ShootEmojiWidget> emojiWidgets = {};
    int countSend = 0;

    return Scaffold(
      // appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(swipeViewProvider.notifier).getTodayConfirmPostList();
      }),
      body: SafeArea(
        child: swipeViewProviderList.fold(
          (failure) => Container(
            color: Colors.cyan,
          ),
          (modelList) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 10,
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(
                      modelList.length,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            key: ValueKey(index),
                            // padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: _currentCellNumber == index
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
                            _currentCellNumber = index;
                          });
                        },
                        enableInfiniteScroll: false),
                    carouselController: _carouselController,
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
                          onTapUp: (details) => showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              clipBehavior: Clip.none,
                              elevation: 0,
                              context: context,
                              builder: (context) {
                                void disposeWidget(UniqueKey key) {
                                  setState(() {
                                    emojiWidgets.remove(key);
                                  });
                                }

                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        clipBehavior: Clip.none,
                                        children: emojiWidgets.values.toList(),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30.0),
                                            child: Text(
                                                "반응을 $countSend 회 보냈어요!",
                                                style: TextStyle(fontSize: 20)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                                children: List<Widget>.generate(
                                              3,
                                              (index) => Row(
                                                children: List<Widget>.generate(
                                                    5, (index) {
                                                  final key = GlobalKey();
                                                  return Expanded(
                                                    key: key,
                                                    flex: 1,
                                                    child: GestureDetector(
                                                      onTapDown: (detail) {},
                                                      onTapUp: (detail) {
                                                        setState(
                                                          () {
                                                            countSend++;
                                                            final animationWidgetKey =
                                                                UniqueKey();
                                                            emojiWidgets
                                                                .addEntries({
                                                              animationWidgetKey: ShootEmojiWidget(
                                                                  key:
                                                                      animationWidgetKey,
                                                                  currentPos: Point(
                                                                      detail
                                                                          .globalPosition
                                                                          .dx,
                                                                      detail
                                                                          .globalPosition
                                                                          .dy),
                                                                  targetPos: Point(
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2,
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .height +
                                                                          50),
                                                                  disposeWidgetFromParent:
                                                                      disposeWidget)
                                                            }.entries);
                                                          },
                                                        );
                                                        print(emojiWidgets
                                                            .length);
                                                      },
                                                      // },
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          // Image(
                                                          //   image: AssetImage(
                                                          //       "images/sample_emoji.png"),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            )),
                                          ),
                                          SizedBox(
                                            height: 60,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                });
                              }).whenComplete(() => emojiWidgets.clear()),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.black,
                            ),
                            child: const Center(
                              child: Text(
                                "😄",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.emoji_emotions),
                          label: Text(""),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShootEmojiWidget extends StatefulWidget {
  ShootEmojiWidget(
      {super.key,
      required this.disposeWidgetFromParent,
      required this.currentPos,
      required this.targetPos});
  Function disposeWidgetFromParent;
  Point currentPos;
  Point targetPos;

  @override
  State<ShootEmojiWidget> createState() => _ShootEmojiWidgetState();
}

class _ShootEmojiWidgetState extends State<ShootEmojiWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late var _yAnimation, _xAnimation;
  late Function disposeWidgetFromParent;
  late double targetXPos;
  final double emojiSize = 50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disposeWidgetFromParent = widget.disposeWidgetFromParent;

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _yAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _xAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    // _animation = Tween<double>(begin: 0, end: 1).animate(_controller, );
    _controller.forward(from: 0.0);
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        disposeWidgetFromParent(widget.key);
        // dispose();
        // super.dispose();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      child: Image(
        width: emojiSize,
        height: emojiSize,
        image: AssetImage("images/heart_icon.png"),
      ),
    );
  }
}
