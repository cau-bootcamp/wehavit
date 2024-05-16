import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';

import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ConfirmPostWidget extends ConsumerStatefulWidget {
  const ConfirmPostWidget({
    required this.confirmPostEntity,
    required this.createdDate,
    super.key,
  });

  final ConfirmPostEntity confirmPostEntity;
  final DateTime createdDate;

  @override
  ConsumerState<ConfirmPostWidget> createState() => _ConfirmPostWidgetState();
}

class _ConfirmPostWidgetState extends ConsumerState<ConfirmPostWidget>
    with TickerProviderStateMixin {
  late Future<int> resolutionDoneCountForWrittenWeek;
  late EitherFuture<UserDataEntity> futureUserDataEntity;
  late Future<ResolutionEntity?> futureResolutionEntity;

  @override
  void initState() {
    super.initState();
    print(widget.createdDate.getMondayDateTime());
    futureUserDataEntity = ref.read(getUserDataFromIdUsecaseProvider)(
        widget.confirmPostEntity.owner!);

    resolutionDoneCountForWrittenWeek = ref
        .read(getTargetResolutionDoneCountForWeekUsecaseProvider)
        .call(
          resolutionId: widget.confirmPostEntity.resolutionId!,
          startMonday: widget.createdDate.getMondayDateTime(),
        )
        .then((result) => result.fold((failure) => -1, (count) => count));

    futureResolutionEntity = ref
        .read(getTargetResolutionEntityUsecaseProvider)
        .call(
            targetUserId: widget.confirmPostEntity.owner!,
            targetResolutionId: widget.confirmPostEntity.resolutionId!)
        .then((result) => result.fold((failure) => null, (entity) => entity));
  }

  bool isShowingCommentField = false;
  bool isTouchMoved = false;
  TextEditingController commentEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(groupPostViewModelProvider);
    var provider = ref.read(groupPostViewModelProvider.notifier);

    ReactionCameraWidgetModel reactionCameraModel =
        ref.watch(reactionCameraWidgetModelProvider);
    ReactionCameraWidgetModelProvider reactionCameraModelProvider =
        ref.read(reactionCameraWidgetModelProvider.notifier);

    Point<double> panningPosition = const Point(0, 0);

    return SizedBox(
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
                              futureUserEntity: futureUserDataEntity,
                            ),
                            if (widget.confirmPostEntity.hasRested == false)
                              Text(
                                // ignore: lines_longer_than_80_chars
                                '${widget.confirmPostEntity.createdAt!.hour > 12 ? '오후' : '오전'} ${widget.confirmPostEntity.createdAt!.hour > 12 ? widget.confirmPostEntity.createdAt!.hour - 12 : widget.confirmPostEntity.createdAt!.hour}시 ${widget.confirmPostEntity.createdAt!.minute}분',
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                                child: const Text(
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
                        FutureBuilder(
                          future: Future.wait([
                            resolutionDoneCountForWrittenWeek,
                            futureResolutionEntity,
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int successCount = snapshot.data![0] as int;
                              ResolutionEntity? resolutionEntity =
                                  snapshot.data![1] as ResolutionEntity?;

                              if (resolutionEntity == null) {
                                return Container();
                              }

                              return ResolutionLinearGaugeWidget(
                                resolutionEntity: resolutionEntity,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),

                        const SizedBox(height: 12.0),
                        ConfirmPostContentWidget(
                          confirmPostEntity: widget.confirmPostEntity,
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
                        onPressed: () {
                          setState(() {
                            isShowingCommentField = !isShowingCommentField;
                          });
                        },
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
                          showEmojiSheet(viewModel, provider, context);
                        },
                      ),
                      Listener(
                        onPointerDown: (event) async {
                          isTouchMoved = false;

                          if (reactionCameraModel.cameraController == null) {
                            return;
                          }

                          panningPosition = Point(
                            event.position.dx,
                            event.position.dy,
                          );

                          reactionCameraModelProvider
                              .updatePanPosition(panningPosition);

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        onPointerUp: (_) async {
                          if (!isTouchMoved) {
                            showToastMessage(context,
                                text: '퀵샷 버튼을 누르고 드래그 해주세요!',
                                icon: const Icon(
                                  Icons.warning,
                                  color: CustomColors.whYellow,
                                ));
                            return;
                          }
                          await reactionCameraModelProvider
                              .setFocusingModeTo(false);

                          if (reactionCameraModel.cameraController == null) {
                            return;
                          }

                          if (reactionCameraModel.isPosInCapturingArea) {
                            final imageFilePath =
                                await reactionCameraModelProvider
                                    .endOnCapturingArea();

                            await provider.sendImageReaction(
                              entity: widget.confirmPostEntity,
                              imageFilePath: imageFilePath,
                            );
                          }

                          setState(() {});
                        },
                        onPointerMove: (event) async {
                          isTouchMoved = true;
                          await reactionCameraModelProvider
                              .setFocusingModeTo(true);

                          panningPosition = Point(
                            event.position.dx,
                            event.position.dy,
                          );

                          reactionCameraModelProvider
                              .updatePanPosition(panningPosition);
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
                            controller: commentEditingController,
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
                                commentEditingController.text,
                              ).whenComplete(() {
                                commentEditingController.clear();

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
          ),
        ],
      ),
    );
  }

  Future<void> sendMessageReaction(
    ConfirmPostEntity confirmPostEntity,
    String comment,
  ) async {
    await ref
        .read(sendCommentReactionToConfirmPostUsecaseProvider)
        .call((confirmPostEntity, comment));
  }

  Future<dynamic> showEmojiSheet(
    GroupPostViewModel viewModel,
    GroupPostViewModelProvider provider,
    BuildContext context,
  ) {
    void disposeWidget(UniqueKey key) {
      if (mounted) {
        setState(() {
          viewModel.emojiWidgets.remove(key);
        });
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
                                  CustomColors.whRedBright,
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
                                                Emojis.emojiList[
                                                    index * 5 + jndex],
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
      await provider.sendEmojiReaction(entity: widget.confirmPostEntity);

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

class ConfirmPostContentWidget extends StatelessWidget {
  const ConfirmPostContentWidget({
    super.key,
    required this.confirmPostEntity,
  });
  final ConfirmPostEntity confirmPostEntity;

  @override
  Widget build(BuildContext context) {
    if (confirmPostEntity.content != null && confirmPostEntity.content != '') {
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
