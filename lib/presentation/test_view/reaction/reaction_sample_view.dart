import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

class ReactionSampleView extends ConsumerStatefulWidget {
  const ReactionSampleView({super.key});

  @override
  ConsumerState<ReactionSampleView> createState() => _ReactionSampleViewState();
}

class _ReactionSampleViewState extends ConsumerState<ReactionSampleView> {
  late ConfirmPostEntity? targetPostEntity = null;
  // late GetConfirmPostListUsecase _getConfirmPostListUsecase;
  // late UploadReactionToTargetConfirmPostUsecase
  //     _uploadReactionToTargetConfirmPostUsecase;

  @override
  Widget build(BuildContext context) {
    final getConfirmPostListUsecase =
        ref.watch(getConfirmPostListUsecaseProvider);
    final sendEmojiReactionToConfirmPostUsecase =
        ref.watch(sendEmojiReactionToConfirmPostUsecaseProvider);
    final sendQuickShotReactionToConfirmPostUsecase =
        ref.watch(sendQuickShotReactionToConfirmPostUsecaseProvider);
    final sendCommentReactionToConfrimPostUsecase =
        ref.watch(sendCommentReactionToConfirmPostUsecaseProvider);
    final getUnreadReactionListUsecase =
        ref.watch(getUnreadReactionListUsecaseProvider);
    final getUnreadReactionListFromConfirmPostUsecase =
        ref.watch(getReactionListFromConfirmPostUsecaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reaction Sample View')),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                const Text('Target Post'),
                ElevatedButton(
                  onPressed: () async {
                    final fetchedEntity =
                        (await getConfirmPostListUsecase(DateTime.now())).fold(
                      (l) => null,
                      (r) => r.isEmpty ? null : r.first,
                    );
                    setState(() {
                      targetPostEntity = fetchedEntity;
                    });
                  },
                  child: const Text('load element'),
                ),
                Text(
                  targetPostEntity != null
                      ? targetPostEntity!.title!
                      : 'no element',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    emojiSheetWidget(context).whenComplete(() {
                      sendEmojiReactionToConfirmPostUsecase(
                        (
                          targetPostEntity!,
                          [2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                        ),
                      );
                    });
                  },
                  child: Text('emoji'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    sendCommentReactionToConfrimPostUsecase(
                      (
                        targetPostEntity!,
                        '행복한 하루 보내세요!!',
                      ),
                    );
                  },
                  child: Text('text'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final reactionImage = await getPhotoLibraryImage();

                    if (reactionImage == null) {
                      return;
                    }

                    sendQuickShotReactionToConfirmPostUsecase(
                      (
                        targetPostEntity!,
                        reactionImage,
                      ),
                    );
                  },
                  child: Text('camera'),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final reactionList =
                    await getUnreadReactionListUsecase(NoParams());
                print(reactionList);
              },
              child: Text('receive reactions'),
            ),
            ElevatedButton(
              onPressed: () async {
                final reactionList =
                    await getUnreadReactionListFromConfirmPostUsecase(
                  targetPostEntity!,
                );
                print(reactionList);
              },
              child: Text('receive reactions from confirmpost'),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      debugPrint('이미지 선택안함');
      return null;
    }
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
            // _swipeViewModel.emojiWidgets.remove(key);
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
                  // children: _swipeViewModel.emojiWidgets.values.toList(),
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
                              // _swipeViewModel.countSend.toString(),
                              // style: TextStyle(
                              //   fontSize: 40 +
                              //       24 *
                              //           min(
                              //             1,
                              //             _swipeViewModel.countSend / 24,
                              //           ),
                              //   color: Color.lerp(
                              //     CustomColors.whYellow,
                              //     CustomColors.whRedBright,
                              //     min(1, _swipeViewModel.countSend / 24),
                              //   ),
                              //   fontWeight: FontWeight.w700,
                              //   fontStyle: FontStyle.italic,
                              // ),
                              'hi',
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
        // _swipeViewModel.countSend++;
        // _swipeViewModel.sendingEmojis[index * 5 + jndex] += 1;
        // final animationWidgetKey = UniqueKey();
        // _swipeViewModel.emojiWidgets.addEntries(
        //   {
        //     animationWidgetKey: ShootEmojiWidget(
        //       key: animationWidgetKey,
        //       emojiIndex: index * 5 + jndex,
        //       currentPos: Point(detail.globalPosition.dx, 100),
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
