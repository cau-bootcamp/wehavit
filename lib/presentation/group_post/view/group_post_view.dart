import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/reaction/reaction.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class GroupPostView extends ConsumerStatefulWidget {
  const GroupPostView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  ConsumerState<GroupPostView> createState() => _GroupPostViewState();
}

class _GroupPostViewState extends ConsumerState<GroupPostView> {
  Point<double> panPosition = Point<double>(0, 0);
  List<DateTime> calendartMondayDateList = [
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 7)),
  ];

  late final ConfirmPostEntity postEntity;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ref.read(groupPostViewModelProvider.notifier).initializeCamera();

    ref
        .watch(getMyResolutionListUsecaseProvider)
        .call(NoParams())
        .then((value) => value.fold((l) => null, (r) => r.first))
        .then((value) async {
      if (value != null) {
        final resEntity = value;
        final confirmPostEntity = await ref
            .watch(getConfirmPostListForResolutionIdUsecaseProvider)
            (resEntity!.resolutionId ?? '')
            .then(
          (value) {
            return value.fold(
              (l) => null,
              (pList) => pList.first,
            );
          },
        );
        return confirmPostEntity;
      }
    }).then((value) {
      postEntity = value!;
    }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);
    final reactionModel = ref.watch(reactionCameraWidgetModelProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.whBlack,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              widget.groupEntity.groupName,
              style: const TextStyle(
                color: CustomColors.whWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.campaign_outlined,
                  color: CustomColors.whWhite,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.error_outline,
                  color: CustomColors.whWhite,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.people_outline,
                  color: CustomColors.whWhite,
                  size: 30,
                ),
              )
            ],
          ),
          body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 16.0),
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '2024년 2월 27일',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CustomColors.whWhite,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          padding: EdgeInsets.only(top: 12),
                          child: CarouselSlider.builder(
                            itemBuilder: (context, index, realIndex) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List<Widget>.generate(
                                  7,
                                  (jndex) => Expanded(
                                    child: GestureDetector(
                                      onTapUp: (details) {
                                        print('tap date');
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        height: 64,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: CustomColors.whBlack,
                                              width: 2,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                offset: Offset(0, 0),
                                                color: CustomColors.whBlack,
                                              ),
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 6,
                                                color: CustomColors.whYellow,
                                                // color: CustomColors.whGrey,
                                                // color: CustomColors.whYellowDark,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '30',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  // color: CustomColors.whPlaceholderGrey,
                                                  color: CustomColors.whBlack,
                                                ),
                                              ),
                                              Text(
                                                index.toString(),
                                                style: TextStyle(
                                                  height: 1.0,
                                                  fontFamily: 'Giants',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  // color: CustomColors.whPlaceholderGrey,
                                                  color: CustomColors.whBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: calendartMondayDateList.length,
                            options: CarouselOptions(
                              height: 64,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: false,
                              reverse: true,
                              initialPage: calendartMondayDateList.length - 1,
                              onPageChanged: (index, reason) {
                                if (index ==
                                    calendartMondayDateList.length - 1) {
                                  // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
                                  calendartMondayDateList.insert(
                                    0,
                                    calendartMondayDateList.first.subtract(
                                      const Duration(days: 7),
                                    ),
                                  );
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20.0),
                    physics: reactionModel.isFocusingMode
                        ? NeverScrollableScrollPhysics()
                        : AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ConfirmPostWidget(
                          panEndCallback: endOnCapturingPosition,
                          panUpdateCallback: updatePanPosition,
                          confirmPostEntity: postEntity!,
                        ),
                        SizedBox(height: 12.0),
                        ConfirmPostWidget(
                          panEndCallback: endOnCapturingPosition,
                          panUpdateCallback: updatePanPosition,
                          confirmPostEntity: postEntity!,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (viewModel.isCameraInitialized)
          ReactionCameraWidget(
            cameraController: viewModel.cameraController,
            panPosition: panPosition,
          ),
        const ReactionAnimationWidget(),
      ],
    );
  }

  void updatePanPosition(Point<double> position) {
    setState(() {
      panPosition = position;
      print(position);
    });
  }

  Future<void> endOnCapturingPosition(
    Point<double> position,
    ConfirmPostEntity entity,
  ) async {
    final imageFilePath =
        await ref.watch(reactionCameraWidgetModelProvider.notifier).capture();

    ref
        .read(groupPostViewModelProvider.notifier)
        .sendImageReaction(imageFilePath: imageFilePath, entity: entity);
  }
}

class ConfirmPostWidget extends ConsumerStatefulWidget {
  const ConfirmPostWidget({
    required this.panEndCallback,
    required this.panUpdateCallback,
    required this.confirmPostEntity,
    super.key,
  });

  final ConfirmPostEntity confirmPostEntity;
  final Function panEndCallback;
  final Function panUpdateCallback;

  @override
  ConsumerState<ConfirmPostWidget> createState() => _ConfirmPostWidgetState();
}

class _ConfirmPostWidgetState extends ConsumerState<ConfirmPostWidget> {
  ResolutionEntity? resEntity;
  ConfirmPostEntity? confirmPostEntity;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ref
        .watch(getMyResolutionListUsecaseProvider)
        .call(NoParams())
        .then((value) => value.fold((l) => null, (r) => r.first))
        .then((value) async {
      if (value != null) {
        resEntity = value;
        confirmPostEntity = await ref
            .watch(getConfirmPostListForResolutionIdUsecaseProvider)
            (resEntity!.resolutionId ?? '')
            .then(
          (value) {
            return value.fold((l) => null, (pList) => pList.first);
          },
        );
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);

    ReactionCameraWidgetModel _reactionCameraWidgetModel =
        ref.watch(reactionCameraWidgetModelProvider);
    final _reactionCameraWidgetModelProvider =
        ref.read(reactionCameraWidgetModelProvider.notifier);

    Point<double> panningPosition = Point(0, 0);

    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: CustomColors.whDarkBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      border: Border(
                        top: BorderSide(
                          width: 8.0,
                          color: CustomColors.whDarkBlack,
                        ),
                        left: BorderSide(
                          width: 8.0,
                          color: CustomColors.whDarkBlack,
                        ),
                        right: BorderSide(
                          width: 8.0,
                          color: CustomColors.whDarkBlack,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 4.0,
                      bottom: 12.0,
                    ),

                    // height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            UserProfileBar(
                              futureUserEntity: Future(
                                () => right(UserDataEntity.dummyModel),
                              ),
                            ),
                            if (true)
                              Text(
                                // ignore: lines_longer_than_80_chars
                                '${confirmPostEntity!.createdAt!.hour > 12 ? '오전' : '오후'} ${confirmPostEntity!.createdAt!.hour > 12 ? confirmPostEntity!.createdAt!.hour - 12 : confirmPostEntity!.createdAt!.hour}시 ${confirmPostEntity!.createdAt!.minute}분',
                                style: const TextStyle(
                                  color: CustomColors.whWhite,
                                ),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: CustomColors.whRed,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text(
                                  '오늘 실천 실패 😢',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300,
                                    color: CustomColors.whWhite,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        // const SizedBox(height: 12.0),
                        if (resEntity != null)
                          ResolutionLinearGaugeWidget(
                            ResolutionListCellWidgetModel(
                              entity: resEntity!,
                              successCount: 3,
                            ),
                          ),
                        const SizedBox(height: 12.0),
                        ConfirmPostContentWidget(
                          confirmPostEntity: confirmPostEntity!,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          color: CustomColors.whWhite,
                        ),
                        label: const Text(
                          '코멘트',
                          style: TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      TextButton.icon(
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: CustomColors.whWhite,
                        ),
                        label: const Text(
                          '이모지',
                          style: TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        onPressed: () async {
                          showEmojiSheet(context);
                        },
                      ),
                      Listener(
                        // behavior: HitTestBehavior.translucent,
                        // onTapDown: (_) {
                        //   setState(() {
                        //     _reactionCameraWidgetModelProvider
                        //         .setFocusingModeTo(true);
                        //   });
                        // },
                        // onTapUp: (_) {
                        //   setState(() {
                        //     _reactionCameraWidgetModelProvider
                        //         .setFocusingModeTo(false);
                        //   });
                        // },
                        onPointerDown: (event) {
                          print('pan down');
                          panningPosition = Point(
                            event.position.dx,
                            event.position.dy,
                          );
                          widget.panUpdateCallback(panningPosition);

                          _reactionCameraWidgetModel =
                              _reactionCameraWidgetModel.copyWith(
                            currentButtonPosition: Point(
                              event.position.dx,
                              event.position.dy,
                            ),
                          );

                          setState(() {
                            _reactionCameraWidgetModelProvider
                                .setFocusingModeTo(true);
                          });
                        },
                        onPointerUp: (_) async {
                          if (_reactionCameraWidgetModelProvider
                              .isPosInCameraAreaOf(panningPosition)) {
                            widget.panEndCallback(
                              panningPosition,
                              widget.confirmPostEntity,
                            );
                          }
                          _reactionCameraWidgetModelProvider
                              .setFocusingModeTo(false);
                        },
                        onPointerMove: (event) {
                          panningPosition = Point(
                            event.position.dx,
                            event.position.dy,
                          );
                          widget.panUpdateCallback(panningPosition);

                          _reactionCameraWidgetModel =
                              _reactionCameraWidgetModel.copyWith(
                            currentButtonPosition: Point(
                              event.position.dx,
                              event.position.dy,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: CustomColors.whWhite,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                '퀵샷',
                                style: TextStyle(
                                  color: CustomColors.whWhite,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        bottom: 8.0,
                      ),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            style: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: CustomColors.whYellowDark,
                              contentPadding: EdgeInsets.only(
                                left: 12.0,
                                right: 44.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send_outlined,
                              color: CustomColors.whWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showEmojiSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
      context: context,
      builder: (context) {
        void disposeWidget(UniqueKey key) {
          // setState(() {
          //   _mainViewModel.emojiWidgets.remove(key);
          // });
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GradientBottomSheet(
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Expanded(
                  //   flex: 2,
                  //   // padding: const EdgeInsets.only(bottom: 30.0),
                  //   child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        // child: Text(
                        //   _mainViewModel.countSend.toString(),
                        //   style: TextStyle(
                        //     fontSize: 40 +
                        //         24 *
                        //             min(
                        //               1,
                        //               _mainViewModel.countSend / 24,
                        //             ),
                        //     color: Color.lerp(
                        //       CustomColors.whYellow,
                        //       CustomColors.whRedBright,
                        //       min(1, _mainV`iewModel.countSend / 24),
                        //     ),
                        //     fontWeight: FontWeight.w700,
                        //     fontStyle: FontStyle.italic,
                        //   ),
                        // ),
                      ),
                      const Text(
                        '반응을 보내주세요!',
                        style: TextStyle(
                          fontSize: 24,
                          color: CustomColors.whYellow,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 36.0,
                      )
                    ],
                  ),
                  // ),
                  Builder(
                    builder: (context) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                      );
                    },
                  ),
                  // Expanded(child: Container()),
                  // const SizedBox(
                  //   height: 60,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void setAnimationVariables() {
    // _mainViewModel.animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 200),
    // );
    // _mainViewModel.animation = Tween<double>(begin: 0, end: 130).animate(
    //   CurvedAnimation(
    //     parent: _mainViewModel.animationController,
    //     curve: Curves.linear,
    //   ),
    // );
    // _mainViewModel.animationController.value = 1;
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
        // _mainViewModel.countSend++;
        // _mainViewModel.sendingEmojis[index * 5 + jndex] += 1;
        // final animationWidgetKey = UniqueKey();
        // _mainViewModel.emojiWidgets.addEntries(
        //   {
        //     animationWidgetKey: ShootEmojiWidget(
        //       key: animationWidgetKey,
        //       emojiIndex: index * 5 + jndex,
        //       currentPos: Point(detail.globalPosition.dx, 0),
        //       targetPos: Point(
        //         MediaQuery.of(context).size.width / 2,
        //         MediaQuery.of(context).size.height - 500 + 200,
        //       ),
        //       disposeWidgetFromParent: disposeWidget,
        //     ),
        //   }.entries,
        // );
      },
    );
  }
}

class ConfirmPostContentWidget extends StatelessWidget {
  const ConfirmPostContentWidget({
    super.key,
    required this.confirmPostEntity,
  });
  final ConfirmPostEntity confirmPostEntity;

  @override
  Widget build(BuildContext context) {
    if (confirmPostEntity.content != null && confirmPostEntity.content! != '') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 100,
              ),
              child: Text(
                confirmPostEntity.content!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: CustomColors.whWhite,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          if (confirmPostEntity.imageUrlList!.isNotEmpty)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(64),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return Stack(
                          children: [
                            child,
                            if (confirmPostEntity.imageUrlList!.length > 1)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  // ignore: lines_longer_than_80_chars
                                  '+${confirmPostEntity.imageUrlList!.length - 1}',
                                  style: const TextStyle(
                                    color: CustomColors.whWhite,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        );
                      } else {
                        return Container(
                          color: CustomColors.whBlack,
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: CustomColors.whYellow,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    fit: BoxFit.cover,
                    width: 150,
                    height: 100,
                    image: NetworkImage(
                      confirmPostEntity.imageUrlList!.first,
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    } else {
      if (confirmPostEntity.imageUrlList!.length == 1) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: CustomColors.whBlack,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    confirmPostEntity.imageUrlList![0],
                  ),
                ),
              ),
            ),
          ],
        );
      } else if (confirmPostEntity.imageUrlList!.length == 2) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: CustomColors.whBlack,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    confirmPostEntity.imageUrlList![0],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: CustomColors.whBlack,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    confirmPostEntity.imageUrlList![1],
                  ),
                ),
              ),
            ),
          ],
        );
      } else if (confirmPostEntity.imageUrlList!.length == 3) {
        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(64),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Container(
                          color: CustomColors.whBlack,
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: CustomColors.whYellow,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      confirmPostEntity.imageUrlList![0],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(64),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image(
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                color: CustomColors.whBlack,
                                child: const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.whYellow,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            confirmPostEntity.imageUrlList![1],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(64),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image(
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                color: CustomColors.whBlack,
                                child: const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.whYellow,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            confirmPostEntity.imageUrlList![2],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          constraints: const BoxConstraints(minHeight: 150),
          child: Center(
            child: SizedBox(
              width: 120,
              height: 120,
              // TODO: placeholder asset image 설정하기
              child: Image.asset(
                'assets/images/emoji_3d/smiling_face_with_heart-eyes_3d.png',
              ),
            ),
          ),
        );
      }
    }
  }
}
