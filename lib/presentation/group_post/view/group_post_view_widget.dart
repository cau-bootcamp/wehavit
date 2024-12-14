import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wehavit/common/common.dart';

import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';

class ConfirmPostWidget extends ConsumerStatefulWidget {
  const ConfirmPostWidget({
    required this.confirmPostEntity,
    required this.createdDate,
    this.showReactionToolbar = true,
    super.key,
  });

  final ConfirmPostEntity confirmPostEntity;
  final DateTime createdDate;
  final bool showReactionToolbar;

  @override
  ConsumerState<ConfirmPostWidget> createState() => _ConfirmPostWidgetState();
}

class _ConfirmPostWidgetState extends ConsumerState<ConfirmPostWidget> with TickerProviderStateMixin {
  late EitherFuture<List<bool>> resolutionDoneListForWrittenWeek;
  late EitherFuture<UserDataEntity> futureUserDataEntity;
  late EitherFuture<ResolutionEntity> futureResolutionEntity;
  late UserDataEntity? myUserEntity;

  bool isShowingQuickshotPresets = false;

  @override
  void initState() {
    super.initState();
    unawaited(loadData());
  }

  Future<void> loadData() async {
    futureUserDataEntity = ref.read(getUserDataFromIdUsecaseProvider)(
      widget.confirmPostEntity.owner!,
    );

    resolutionDoneListForWrittenWeek = ref.read(getTargetResolutionDoneListForWeekUsecaseProvider).call(
          resolutionId: widget.confirmPostEntity.resolutionId!,
          startMonday: widget.createdDate.getMondayDateTime(),
        );

    futureResolutionEntity = ref.read(getTargetResolutionEntityUsecaseProvider)(
      targetUserId: widget.confirmPostEntity.owner!,
      targetResolutionId: widget.confirmPostEntity.resolutionId!,
    );

    myUserEntity = await ref.read(myPageViewModelProvider).futureMyUserDataEntity?.then(
          (result) => result.fold(
            (failure) => null,
            (entity) => entity,
          ),
        );

    ref.read(groupPostViewModelProvider.notifier).getQuickshotPresets();
  }

  bool isShowingCommentField = false;

  late GroupPostViewModel viewModel;
  late GroupPostViewModelProvider provider;

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(groupPostViewModelProvider);
    provider = ref.read(groupPostViewModelProvider.notifier);

    // Point<double> panningPosition = const Point(0, 0);

    return EitherFutureBuilder<ResolutionEntity>(
      target: futureResolutionEntity,
      forFail: Container(),
      forWaiting: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomColors.whDarkBlack,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border: Border(
                  top: const BorderSide(
                    width: 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                  left: const BorderSide(
                    width: 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                  right: const BorderSide(
                    width: 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                  bottom: BorderSide(
                    width: widget.showReactionToolbar ? 0.1 : 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 12.0,
                    ),
                    height: 224,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.whYellow,
                      ),
                    ),
                  ),
                  if (widget.showReactionToolbar)
                    ConfirmPostReactionButtonListWidget(
                      onMessagePressed: () {},
                      onEmojiPressed: () {},
                      onQuickshotTapDown: (_) {},
                      onQuickshotTapUp: (_) {},
                      onQuickshotLongPressStart: (_) {},
                      onQuickshotLongPressMove: (_) {},
                      onQuickshotLongPressEnd: (_) {},
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      mainWidgetCallback: (resolutionEntity) => SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomColors.whDarkBlack,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border: Border(
                  top: const BorderSide(
                    width: 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                  left: const BorderSide(
                    width: 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                  right: const BorderSide(
                    width: 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                  bottom: BorderSide(
                    width: widget.showReactionToolbar ? 0.1 : 8.0,
                    color: CustomColors.whDarkBlack,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 12.0,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                UserProfileBar(
                                  futureUserEntity: futureUserDataEntity,
                                  secondaryText:
                                      // ignore: lines_longer_than_80_chars
                                      '${widget.confirmPostEntity.createdAt!.hour >= 12 ? '오후' : '오전'} ${widget.confirmPostEntity.createdAt!.hour > 12 ? widget.confirmPostEntity.createdAt!.hour - 12 : widget.confirmPostEntity.createdAt!.hour}시 ${widget.confirmPostEntity.createdAt!.minute}분',
                                ),
                                if (widget.confirmPostEntity.hasRested == true)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: CustomColors.whRed,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 6.0,
                                    ),
                                    child: const Text(
                                      '오늘은 SKIP',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Pretendard',
                                        color: CustomColors.whWhite,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            // const SizedBox(height: 12.0),

                            ResolutionLinearGaugeWidget(
                              resolutionEntity: resolutionEntity,
                              futureDoneList: resolutionDoneListForWrittenWeek,
                            ),

                            const SizedBox(height: 12.0),
                            ConfirmPostContentWidget(
                              confirmPostEntity: widget.confirmPostEntity,
                            ),
                          ],
                        ),
                        if (isShowingQuickshotPresets)
                          Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: CustomColors.whDarkBlack.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (viewModel.quickshotPresets.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text(
                                      // ignore: lines_longer_than_80_chars
                                      '미리 퀵샷을 찍어두고 보낼 수도 있어요\n저장 없이 보내려면 버튼을 꾹! 눌러주세요',
                                      style: TextStyle(
                                        color: CustomColors.whWhite,
                                        height: 1.1,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                ...viewModel.quickshotPresets.map((entity) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CustomColors.whDarkBlack,
                                        border: Border.all(
                                          color: CustomColors.whWhite,
                                        ),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          await provider
                                              .sendPresetImageReaction(
                                            presetEntity: entity,
                                            entity: widget.confirmPostEntity,
                                            myUserEntity: myUserEntity,
                                          )
                                              .whenComplete(() {
                                            showToastMessage(
                                              context,
                                              text: '친구에게 퀵샷으로 응원을 보냈어요',
                                              icon: const Icon(
                                                Icons.emoji_emotions,
                                                color: CustomColors.whYellow,
                                              ),
                                            );
                                          });
                                        },
                                        onLongPress: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: const Text(
                                                  '저장된 퀵샷을 지우시겠어요?',
                                                ),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(); //창 닫기
                                                    },
                                                    child: const Text('아니요'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      provider
                                                          .removeQuickshotPresetEntity(
                                                        entity: entity,
                                                      )
                                                          .whenComplete(() async {
                                                        await provider.getQuickshotPresets();
                                                        setState(() {});
                                                        Navigator.of(context).pop(); //창 닫기
                                                      });
                                                    },
                                                    child: const Text('네'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        padding: EdgeInsets.zero,
                                        child: ProfileImageCircleWidget(
                                          size: 40,
                                          url: entity.url,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                if (viewModel.quickshotPresets.length < 5)
                                  // 추가 버튼
                                  Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CustomColors.whDarkBlack,
                                      border: Border.all(
                                        color: CustomColors.whWhite,
                                      ),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTapDown: (_) {},
                                      onTapUp: (_) {
                                        showToastMessage(
                                          context,
                                          text: '추가 버튼을 누른 채로 드래그 해주세요!',
                                          icon: const Icon(
                                            Icons.warning,
                                            color: CustomColors.whYellow,
                                          ),
                                        );
                                      },
                                      onLongPressStart: (_) async {
                                        PermissionStatus permission = await Permission.camera.status;

                                        if (permission == PermissionStatus.denied) {
                                          await Permission.camera.request();
                                        }
                                        if (permission == PermissionStatus.granted) {
                                          reactionCameraWidgetModeNotifier.value = ReactionCameraWidgetMode.preset;
                                        }
                                      },
                                      onLongPressMoveUpdate: (detail) {
                                        cameraPointerPositionNotifier.value = detail.globalPosition;
                                      },
                                      onLongPressEnd: (_) async {
                                        final needCapture = cameraPointerPositionNotifier.isPosInCapturingArea;

                                        if (needCapture) {
                                          final imageFilePath = await ref.read(reactionCameraWidgetModelProvider.notifier).endOnCapturingArea();

                                          cameraPointerPositionNotifier.value = Offset.zero;
                                          reactionCameraWidgetModeNotifier.value = ReactionCameraWidgetMode.none;

                                          await provider.uploadQuickshotPreset(imageFilePath: imageFilePath).whenComplete(() async {
                                            await provider.getQuickshotPresets();
                                          }).whenComplete(() {
                                            if (mounted) {
                                              showToastMessage(
                                                context,
                                                text: '퀵샷을 저장했어요',
                                                icon: const Icon(
                                                  Icons.emoji_emotions,
                                                  color: CustomColors.whYellow,
                                                ),
                                              );
                                            }
                                            setState(() {});
                                          });
                                        } else {
                                          cameraPointerPositionNotifier.value = Offset.zero;
                                          reactionCameraWidgetModeNotifier.value = ReactionCameraWidgetMode.none;
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          color: CustomColors.whBrightGrey,
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    // Listener(
                                    //   onPointerDown: (event) async {
                                    //     isTouchMoved = false;
                                    //     setState(() {
                                    //       reactionCameraModel.isAddingPreset = true;
                                    //     });

                                    //     reactionCameraModel.nonScrollMode = true;

                                    //     panningPosition = Point(
                                    //       event.position.dx,
                                    //       event.position.dy,
                                    //     );

                                    //     reactionCameraModelProvider.updatePanPosition(panningPosition);
                                    //   },
                                    //   onPointerUp: (event) async {
                                    //     reactionCameraModel.nonScrollMode = false;

                                    //     _isFunctionCalled = false;
                                    //     if (!isTouchMoved) {
                                    //       showToastMessage(
                                    //         context,
                                    //         text: '추가 버튼을 누른 채로 드래그 해주세요!',
                                    //         icon: const Icon(
                                    //           Icons.warning,
                                    //           color: CustomColors.whYellow,
                                    //         ),
                                    //       );
                                    //       return;
                                    //     }

                                    //     if (ref.read(reactionCameraWidgetModelProvider).isPosInCapturingArea) {
                                    //       final imageFilePath = await reactionCameraModelProvider.endOnCapturingArea();

                                    //       reactionCameraModelProvider.setFocusingModeTo(false);

                                    //       await provider
                                    //           .uploadQuickshotPreset(
                                    //         imageFilePath: imageFilePath,
                                    //       )
                                    //           .whenComplete(() async {
                                    //         await provider.getQuickshotPresets();
                                    //       }).whenComplete(() {
                                    //         setState(() {});
                                    //       });
                                    //     }

                                    //     reactionCameraModelProvider.setFocusingModeTo(false);

                                    //     await reactionCameraModelProvider.disposeCamera();
                                    //   },
                                    //   onPointerMove: (event) async {
                                    //     WidgetsBinding.instance.addPostFrameCallback((_) {
                                    //       reactionCameraModelProvider.setFocusingModeTo(true);
                                    //     });

                                    //     if (ref
                                    //             .read(
                                    //               reactionCameraWidgetModelProvider,
                                    //             )
                                    //             .cameraController ==
                                    //         null) {
                                    //       if (!_isFunctionCalled) {
                                    //         reactionCameraModelProvider.initializeCamera();
                                    //         _isFunctionCalled = true;
                                    //       }

                                    //       return;
                                    //     }

                                    //     isTouchMoved = true;

                                    //     panningPosition = Point(
                                    //       event.position.dx,
                                    //       event.position.dy,
                                    //     );

                                    //     reactionCameraModelProvider.updatePanPosition(panningPosition);
                                    //   },
                                    //   child: const Icon(
                                    //     color: CustomColors.whBrightGrey,
                                    //     Icons.add,
                                    //     size: 20,
                                    //   ),
                                    // ),
                                  )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.showReactionToolbar)
                    ConfirmPostReactionButtonListWidget(
                      onMessagePressed: () {
                        setState(() {
                          isShowingCommentField = !isShowingCommentField;
                        });
                      },
                      onEmojiPressed: () async {
                        showEmojiSheet(viewModel, provider, context);
                      },
                      onQuickshotTapDown: (event) async {},
                      onQuickshotTapUp: (event) async {
                        setState(() {
                          isShowingQuickshotPresets = !isShowingQuickshotPresets;
                        });
                      },
                      onQuickshotLongPressStart: (detail) async {
                        PermissionStatus permission = await Permission.camera.status;

                        if (permission == PermissionStatus.denied) {
                          await Permission.camera.request();
                        }
                        if (permission == PermissionStatus.granted) {
                          reactionCameraWidgetModeNotifier.value = ReactionCameraWidgetMode.quickshot;
                        }
                      },
                      onQuickshotLongPressMove: (detail) {
                        cameraPointerPositionNotifier.value = detail.globalPosition;
                      },
                      onQuickshotLongPressEnd: (detail) async {
                        final needCapture = cameraPointerPositionNotifier.isPosInCapturingArea;

                        if (needCapture) {
                          final imageFilePath = await ref.read(reactionCameraWidgetModelProvider.notifier).endOnCapturingArea();

                          await provider
                              .sendImageReaction(
                            entity: widget.confirmPostEntity,
                            imageFilePath: imageFilePath,
                            myUserEntity: myUserEntity,
                          )
                              .whenComplete(() {
                            if (mounted) {
                              showToastMessage(
                                context,
                                text: '친구에게 퀵샷으로 응원을 보냈어요',
                                icon: const Icon(
                                  Icons.emoji_emotions,
                                  color: CustomColors.whYellow,
                                ),
                              );
                            }
                          });
                        }

                        cameraPointerPositionNotifier.value = Offset.zero;
                        reactionCameraWidgetModeNotifier.value = ReactionCameraWidgetMode.none;
                      },
                    ),
                  Visibility(
                    visible: isShowingCommentField,
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
                            controller: viewModel.commentEditingController,
                            style: const TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: CustomColors.whYellowDark,
                              contentPadding: const EdgeInsets.only(
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
                            onPressed: () async {
                              sendMessageReaction(
                                widget.confirmPostEntity,
                              ).whenComplete(() {
                                viewModel.commentEditingController.clear();

                                setState(() {
                                  isShowingCommentField = false;
                                });
                              });
                            },
                            icon: const Icon(
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
          ],
        ),
      ),
    );
  }

  Future<void> sendMessageReaction(
    ConfirmPostEntity confirmPostEntity,
  ) async {
    await ref
        .read(groupPostViewModelProvider.notifier)
        .sendTextReaction(
          entity: confirmPostEntity,
          myUserEntity: myUserEntity,
        )
        .whenComplete(() {
      showToastMessage(
        context,
        text: '친구에게 메시지로 응원을 보냈어요',
        icon: const Icon(
          Icons.emoji_emotions,
          color: CustomColors.whYellow,
        ),
      );
    });
  }

  Future<dynamic> showEmojiSheet(
    GroupPostViewModel viewModel,
    GroupPostViewModelProvider provider,
    BuildContext context,
  ) {
    void disposeWidget(UniqueKey key) {
      if (mounted) {
        viewModel.emojiWidgets.remove(key);
      }
    }

    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: viewModel.emojiWidgets.values.toList(),
                ),
                GradientBottomSheet(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(bottom: 16),
                            height: 70,
                            child: Text(
                              viewModel.countSend.toString(),
                              style: TextStyle(
                                fontSize: 40 +
                                    24 *
                                        min(
                                          1,
                                          viewModel.countSend / 24,
                                        ),
                                color: Color.lerp(
                                  CustomColors.whYellow,
                                  CustomColors.whRed,
                                  min(1, viewModel.countSend / 24),
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
                          const SizedBox(
                            height: 36.0,
                          ),
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
                                            viewModel,
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
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() async {
      if (viewModel.countSend != 0) {
        await provider
            .sendEmojiReaction(
          entity: widget.confirmPostEntity,
          myUserEntity: myUserEntity,
        )
            .whenComplete(
          () {
            showToastMessage(
              context,
              text: '친구에게 이모지로 응원을 보냈어요',
              icon: const Icon(
                Icons.emoji_emotions,
                color: CustomColors.whYellow,
              ),
            );
          },
        );
      }

      viewModel.countSend = 0;
      provider.resetSendingEmojis();
      viewModel.emojiWidgets.clear();
    });
  }

  void setAnimationVariables(GroupPostViewModel viewModel) {
    viewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    viewModel.animation = Tween<double>(begin: 0, end: 130).animate(
      CurvedAnimation(
        parent: viewModel.animationController,
        curve: Curves.linear,
      ),
    );
    viewModel.animationController.value = 1;
  }

  void shootEmoji(
    GroupPostViewModel viewModel,
    StateSetter setState,
    int index,
    int jndex,
    TapUpDetails detail,
    BuildContext context,
    void Function(UniqueKey key) disposeWidget,
  ) {
    return setState(
      () {
        viewModel.countSend++;
        viewModel.sendingEmojis[index * 5 + jndex] += 1;
        final animationWidgetKey = UniqueKey();
        viewModel.emojiWidgets.addEntries(
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
}

class ConfirmPostContentWidget extends StatefulWidget {
  const ConfirmPostContentWidget({
    super.key,
    required this.confirmPostEntity,
  });
  final ConfirmPostEntity confirmPostEntity;

  @override
  State<ConfirmPostContentWidget> createState() => _ConfirmPostContentWidgetState();
}

class _ConfirmPostContentWidgetState extends State<ConfirmPostContentWidget> {
  late List<ImageProvider> imageList;

  @override
  void initState() {
    super.initState();
    imageList = widget.confirmPostEntity.imageUrlList?.map((imageUrl) {
          return NetworkImage(imageUrl);
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.confirmPostEntity.content != null && widget.confirmPostEntity.content != '') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 100,
              ),
              child: Text(
                widget.confirmPostEntity.content!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          if (widget.confirmPostEntity.imageUrlList!.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: CustomColors.whDarkBlack,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPostPhotoView(
                      imageProviderList: imageList,
                      initPageIndex: 0,
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.whDarkBlack,
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
                              if (widget.confirmPostEntity.imageUrlList!.length > 1)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: CustomColors.whBlack,
                                    ),
                                    child: Text(
                                      // ignore: lines_longer_than_80_chars
                                      '+${widget.confirmPostEntity.imageUrlList!.length - 1}',
                                      style: const TextStyle(
                                        color: CustomColors.whWhite,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return const SizedBox(
                            width: 150,
                            height: 100,
                            child: Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
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
                        widget.confirmPostEntity.imageUrlList!.first,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      if (widget.confirmPostEntity.imageUrlList!.length == 1) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: CustomColors.whDarkBlack,
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmPostPhotoView(
                  imageProviderList: imageList,
                  initPageIndex: 0,
                ),
              ),
            );
          },
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.whDarkBlack,
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
                image: NetworkImage(widget.confirmPostEntity.imageUrlList![0]),
              ),
            ),
          ),
        );
      } else if (widget.confirmPostEntity.imageUrlList!.length == 2) {
        return Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: CustomColors.whDarkBlack,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPostPhotoView(
                      imageProviderList: imageList,
                      initPageIndex: 0,
                    ),
                  ),
                );
              },
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.whDarkBlack,
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
                      widget.confirmPostEntity.imageUrlList![0],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: CustomColors.whDarkBlack,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPostPhotoView(
                      imageProviderList: imageList,
                      initPageIndex: 1,
                    ),
                  ),
                );
              },
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.whDarkBlack,
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
                      widget.confirmPostEntity.imageUrlList![1],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else if (widget.confirmPostEntity.imageUrlList!.length == 3) {
        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(0),
                    backgroundColor: CustomColors.whDarkBlack,
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmPostPhotoView(
                          imageProviderList: imageList,
                          initPageIndex: 0,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.whDarkBlack,
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
                        widget.confirmPostEntity.imageUrlList![0],
                      ),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: CustomColors.whDarkBlack,
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmPostPhotoView(
                              imageProviderList: imageList,
                              initPageIndex: 1,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.whDarkBlack,
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
                              widget.confirmPostEntity.imageUrlList![1],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: CustomColors.whDarkBlack,
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmPostPhotoView(
                              imageProviderList: imageList,
                              initPageIndex: 2,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.whDarkBlack,
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
                              widget.confirmPostEntity.imageUrlList![2],
                            ),
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
        // 인증만 남긴 경우
        return const Center(
          child: SizedBox(
            child: Text(
              '오늘 실천 완료!',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    }
  }
}

class ConfirmPostReactionButtonListWidget extends ConsumerWidget {
  const ConfirmPostReactionButtonListWidget({
    super.key,
    required this.onMessagePressed,
    required this.onEmojiPressed,
    required this.onQuickshotTapDown,
    required this.onQuickshotTapUp,
    required this.onQuickshotLongPressStart,
    required this.onQuickshotLongPressMove,
    required this.onQuickshotLongPressEnd,
  });
  final Function() onMessagePressed;
  final Function() onEmojiPressed;
  final Function(TapDownDetails) onQuickshotTapDown;
  final Function(TapUpDetails) onQuickshotTapUp;
  final Function(LongPressStartDetails) onQuickshotLongPressStart;
  final Function(LongPressMoveUpdateDetails) onQuickshotLongPressMove;
  final Function(LongPressEndDetails) onQuickshotLongPressEnd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: CustomColors.whWhite,
            size: 20.0,
          ),
          label: const Text(
            '메시지',
            style: TextStyle(
              color: CustomColors.whWhite,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          onPressed: onMessagePressed,
        ),
        TextButton.icon(
          icon: const Icon(
            Icons.emoji_emotions_outlined,
            color: CustomColors.whWhite,
            size: 20.0,
          ),
          label: const Text(
            '이모지',
            style: TextStyle(
              color: CustomColors.whWhite,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          onPressed: onEmojiPressed,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: onQuickshotTapDown,
          onTapUp: onQuickshotTapUp,
          onLongPressStart: onQuickshotLongPressStart,
          onLongPressMoveUpdate: onQuickshotLongPressMove,
          onLongPressEnd: onQuickshotLongPressEnd,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: CustomColors.whWhite,
                  size: 20.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '퀵샷',
                  style: TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
