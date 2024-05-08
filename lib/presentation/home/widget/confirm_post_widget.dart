import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/home/home.dart';
import 'package:wehavit/presentation/my_page/widgets/resolution_linear_gauge_graph_widget.dart';

class ConfirmPostWidget extends ConsumerStatefulWidget {
  const ConfirmPostWidget({
    super.key,
    required this.entity,
    required this.panUpdateCallback,
    required this.panEndCallback,
  });

  final ConfirmPostEntity entity;
  final Function panUpdateCallback;
  final Function panEndCallback;

  @override
  ConsumerState<ConfirmPostWidget> createState() {
    return _ConfirmPostWidgetState();
  }
}

class _ConfirmPostWidgetState extends ConsumerState<ConfirmPostWidget>
    with SingleTickerProviderStateMixin {
  late String? confirmPostId = widget.entity.id;
  late String? userName = widget.entity.userName;
  late String? userImageUrl = widget.entity.userImageUrl;
  late String? resolutionGoalStatement = widget.entity.resolutionGoalStatement;
  late String? content = widget.entity.content;
  late String? contentImageUrl = widget.entity.imageUrlList!.first;
  late DateTime? postAt = widget.entity.createdAt;
  late final MainViewModel _mainViewModel;
  late final MainViewModelProvider _mainViewModelProvider;

  late ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late ReactionCameraWidgetModelProvider _reactionCameraWidgetModelProvider;

  Point<double> panningPosition = const Point(0, 0);

  bool _initOccurred = false;
  bool _isTextFieldActive = false;

  List<ConfirmPostEntity> confirmPostList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initOccurred) {
      _mainViewModel = ref.watch(mainViewModelProvider);
      _mainViewModelProvider = ref.read(mainViewModelProvider.notifier);

      // await ref
      //     .read(swipeViewModelProvider.notifier)
      //     .getTodayConfirmPostModelList();

      await _mainViewModelProvider.initializeCamera();

      _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
      _reactionCameraWidgetModelProvider =
          ref.read(reactionCameraWidgetModelProvider.notifier);
      // _swipeViewModel.cameraButtonPosition =
      //     _swipeViewModelProvider.getCameraButtonPosition() ??
      //         const Offset(0, 0);

      setAnimationVariables();
      confirmPostList = await _mainViewModelProvider.getConfirmPostListFor(
        resolutionId: widget.entity.resolutionId!,
      );

      _initOccurred = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: CustomColors.whDarkBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImageUrl != null
                            ? NetworkImage(userImageUrl!)
                                as ImageProvider<Object>
                            : const AssetImage('DEBUG_IMAGE'),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userName!,
                        style: const TextStyle(
                          color: CustomColors.whSemiWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ), // icon, name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.whYellowDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          resolutionGoalStatement!,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ), //goal name
                ],
              ),
              // const SizedBox(height: 8),
              // Text(
              //   title!,
              //   style: const TextStyle(
              //     color: CustomColors.whSemiWhite,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(height: 8),
              Container(
                height: 2,
                width: 345,
                color: CustomColors.whYellow,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 120,
                    width: 180,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      strutStyle: const StrutStyle(fontSize: 16.0),
                      text: TextSpan(
                        text: content,
                      ),
                    ),
                  ),
                  //title
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 3, // 4:3 비율 설정
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: contentImageUrl != null
                                ? NetworkImage(contentImageUrl!)
                                    as ImageProvider<Object>
                                : const AssetImage('DEBUG_IMAGE'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 게시물 하단 격려 남기기 기능들
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: CustomColors.whBlack,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        child: ResolutionLinearGaugeGraphWidget(
                          sourceData: confirmPostList,
                          lastPeriod: false,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (_isTextFieldActive == true &&
                          _mainViewModel.textEditingController.text != '') {
                        await _mainViewModelProvider.sendTextReaction(
                          entity: widget.entity,
                        );
                      }
                      setState(() {
                        _isTextFieldActive =
                            !_isTextFieldActive; // 버튼이 눌릴 때마다 텍스트 필드의 보임/숨김 상태를 토글합니다
                      });
                    },
                    icon: const Icon(
                      Icons.messenger_outline,
                      color: CustomColors.whWhite,
                      size: 24,
                    ),
                  ),
                  GestureDetector(
                    onTapUp: (details) async =>
                        emojiSheetWidget(context).whenComplete(() async {
                      _mainViewModelProvider.sendEmojiReaction(
                        entity: widget.entity,
                      );
                      _mainViewModel.countSend = 0;
                    }),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '😄',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  photoReactionButtonWidget()
                ],
              ),
              Visibility(
                visible: _isTextFieldActive,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 35,
                            child: TextFormField(
                              focusNode: _mainViewModel.commentFieldFocus,
                              controller: _mainViewModel.textEditingController,
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: CustomColors.whWhite,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                hintText: '응원 메시지 남기기',
                                hintStyle: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                  color: CustomColors.whWhite,
                                ),

                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 2,
                                ),
                                fillColor: CustomColors.whYellowDark,
                                // 여기에 적절한 커스텀 색상을 사용하세요
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // contentPadding: EdgeInsets.zero,
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        _mainViewModelProvider.sendTextReaction(
                          entity: widget.entity,
                        );
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 16,
                        color: CustomColors.whWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            _mainViewModel.emojiWidgets.remove(key);
          });
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: _mainViewModel.emojiWidgets.values.toList(),
                ),
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        color: CustomColors.whBlack,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: 80,
                        child: Divider(
                          thickness: 4,
                          color: CustomColors.whYellowDark,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      // padding: const EdgeInsets.only(bottom: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            child: Text(
                              _mainViewModel.countSend.toString(),
                              style: TextStyle(
                                fontSize: 40 +
                                    24 *
                                        min(
                                          1,
                                          _mainViewModel.countSend / 24,
                                        ),
                                color: Color.lerp(
                                  CustomColors.whYellow,
                                  CustomColors.whRedBright,
                                  min(1, _mainViewModel.countSend / 24),
                                ),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const Text(
                            '반응을 보내주세요!',
                            style: TextStyle(
                              fontSize: 24,
                              color: CustomColors.whYellow,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                              Emojis
                                                  .emojiList[index * 5 + jndex],
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
                    Expanded(child: Container()),
                    // const SizedBox(
                    //   height: 60,
                    // ),
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
    _mainViewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _mainViewModel.animation = Tween<double>(begin: 0, end: 130).animate(
      CurvedAnimation(
        parent: _mainViewModel.animationController,
        curve: Curves.linear,
      ),
    );
    _mainViewModel.animationController.value = 1;
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
        _mainViewModel.countSend++;
        _mainViewModel.sendingEmojis[index * 5 + jndex] += 1;
        final animationWidgetKey = UniqueKey();
        _mainViewModel.emojiWidgets.addEntries(
          {
            animationWidgetKey: ShootEmojiWidget(
              key: animationWidgetKey,
              emojiIndex: index * 5 + jndex,
              currentPos: Point(detail.globalPosition.dx, 0),
              targetPos: Point(
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height - 500 + 200,
              ),
              disposeWidgetFromParent: disposeWidget,
            ),
          }.entries,
        );
      },
    );
  }

  Container photoReactionButtonWidget() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.black,
      ),
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _reactionCameraWidgetModelProvider.setFocusingModeTo(true);
          });
        },
        onPanEnd: (details) async {
          // if (_reactionCameraWidgetModelProvider
          //     .isPosInCapturingArea(panningPosition)) {
          //   widget.panEndCallback(panningPosition, widget.entity);
          // }
          // _reactionCameraWidgetModelProvider.setFocusingModeTo(false);
        },
        onPanUpdate: (details) {
          panningPosition =
              Point(details.globalPosition.dx, details.globalPosition.dy);

          widget.panUpdateCallback(panningPosition);

          _reactionCameraWidgetModel = _reactionCameraWidgetModel.copyWith(
            currentButtonPosition: Point(
              details.globalPosition.dx,
              details.globalPosition.dy,
            ),
          );
        },
        child: Center(
          child: Text(
            _mainViewModel.isCameraInitialized == true ? '📸' : '❌',
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
