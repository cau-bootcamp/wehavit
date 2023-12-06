import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/model/reaction_camera_widget_model.dart';
import 'package:wehavit/features/swipe_view/presentation/model/swipe_view_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/reaction_camera_widget_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/swipe_dashboard_widget.dart';

class SwipeViewCellWidget extends ConsumerStatefulWidget {
  const SwipeViewCellWidget({
    super.key,
    required this.panUpdateCallback,
    required this.panEndCallback,
    required this.model,
  });

  final ConfirmPostModel model;
  final Function panUpdateCallback;
  final Function panEndCallback;

  @override
  ConsumerState<SwipeViewCellWidget> createState() =>
      _SwipeViewCellWidgetState();
}

class _SwipeViewCellWidgetState extends ConsumerState<SwipeViewCellWidget> {
  late SwipeViewModel _swipeViewModel;
  late SwipeViewModelProvider _swipeViewModelProvider;

  late ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late ReactionCameraWidgetModelProvider _reactionCameraWidgetModelProvider;

  Point<double> panningPosition = const Point(0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _swipeViewModel = ref.watch(swipeViewModelProvider);
    _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);

    _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
    _reactionCameraWidgetModelProvider =
        ref.read(reactionCameraWidgetModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: CustomColors.whDarkBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 프로필 영역
                  Column(
                    children: [
                      FutureBuilder<UserModel>(
                        future: _swipeViewModel
                            .userModelList[_swipeViewModel.currentCellIndex],
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<UserModel> snapshot,
                        ) {
                          // 해당 부분은 data를 아직 받아 오지 못했을때 실행되는 코드
                          if (snapshot.hasData == false) {
                            return const SizedBox(
                              width: 65,
                              height: 65,
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError == true) {
                            return const SizedBox(
                              width: 65,
                              height: 65,
                              child: Placeholder(),
                            );
                          } else {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  foregroundImage:
                                      NetworkImage(snapshot.data!.imageUrl),
                                  backgroundColor: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  snapshot.data!.displayName,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.whWhite,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  '· ${widget.model.resolutionGoalStatement ?? '목표를 불러오지 못했습니다'}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.whYellow,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.model.title ?? '',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 2.5,
                    color: CustomColors.whYellow,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // 사진 영역
                  Expanded(
                    flex: 3,
                    child: Container(
                      constraints: const BoxConstraints.expand(),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        widget.model.imageUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Placeholder();
                        },
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // 통계치 영역
                  SizedBox(
                    height: _swipeViewModel.animation.value,
                    child: SwipeDashboardWidget(
                      confirmPostList: _swipeViewModel
                          .confirmPostList[_swipeViewModel.currentCellIndex],
                    ),
                  ),

                  const Divider(
                    thickness: 2.5,
                    color: CustomColors.whYellow,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // 인증글 영역
                  Container(
                    constraints: const BoxConstraints.expand(height: 120),
                    child: Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.whWhite,
                      ),
                      widget.model.content ?? '',
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height:
                            _swipeViewModel.commentFieldFocus.hasFocus ? 0 : 50,
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            GestureDetector(
                              onTapUp: (details) async =>
                                  emojiSheetWidget(context)
                                      .whenComplete(() async {
                                _swipeViewModelProvider.sendEmojiReaction();
                              }),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '😄',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                            photoReactionButtonWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: _swipeViewModel.commentFieldFocus,
                            controller: _swipeViewModel.textEditingController,
                            // maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: '응원 메시지 남기기',
                              border: InputBorder.none,
                              // contentPadding: EdgeInsets.zero,
                            ),
                            onTap: () {
                              _swipeViewModelProvider.startShrinkingLayout();
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            _swipeViewModelProvider.sendTextReaction();
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
          if (_reactionCameraWidgetModelProvider
              .isPosInCameraAreaOf(panningPosition)) {
            widget.panEndCallback(panningPosition);
          }

          _reactionCameraWidgetModelProvider.setFocusingModeTo(false);
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
            _swipeViewModel.isCameraInitialized == true ? '📸' : '❌',
            style: const TextStyle(fontSize: 30),
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
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: 80,
                        child: Divider(
                          thickness: 4,
                          color: CustomColors.whYellow,
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        '반응을 ${_swipeViewModel.countSend}회 보냈어요!',
                        style: const TextStyle(
                          fontSize: 20,
                          color: CustomColors.whWhite,
                        ),
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
                    Expanded(flex: 2, child: Container()),
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

class SwipeViewCellWidgetModel {
  SwipeViewCellWidgetModel({
    required this.confirmPostModel,
    required this.owner,
  });

  late final ConfirmPostModel confirmPostModel;
  late final UserModel owner;
}
