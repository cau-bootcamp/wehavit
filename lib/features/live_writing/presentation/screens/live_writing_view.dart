import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/effects/emoji_firework_animation/emoji_firework_manager.dart';
import 'package:wehavit/features/live_writing/live_writing.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_post_widget.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

class LiveWritingView extends StatefulHookConsumerWidget {
  const LiveWritingView({super.key});

  @override
  ConsumerState<LiveWritingView> createState() => _LiveWritingViewState();
}

class _LiveWritingViewState extends ConsumerState<LiveWritingView> {
  XFile? imageFile;
  ValueNotifier<bool> isSubmitted = ValueNotifier(false);
  late List<ResolutionModel> resolutionModelList;

  Future<List<String>> getVisibleFriends(WidgetRef ref) {
    return ref
        .read(liveWritingFriendRepositoryProvider)
        .getVisibleFriendEmailList();
  }

  Stream<List<ReactionModel>> reactionNotificationStream(
    WidgetRef ref,
  ) {
    return ref.watch(liveWritingPostRepositoryProvider).getReactionListStream();
  }

  EmojiFireWorkManager emojiFireWorkManager =
      EmojiFireWorkManager(emojiAmount: 1);

  @override
  Widget build(BuildContext context) {
    final activeResolutionList = ref.watch(activeResolutionListProvider);

    final reactionStream = useMemoized(() => reactionNotificationStream(ref));
    final reactionSnapshot = useStream<List<ReactionModel>>(reactionStream);

    reactionStream.listen((event) async {
      if (event.isNotEmpty) {
        List<int> sampledEmojiList = List<int>.generate(15, (index) => 0);
        event.first.emoji.forEach((key, value) {
          sampledEmojiList[int.parse(key.substring(1, 3))] = value;
        });
        emojiFireWorkManager.addFireworkWidget(
          offset: Offset(0, 0),
          emojiReactionCountList: sampledEmojiList,
        );
        await ref
            .read(liveWritingPostRepositoryProvider)
            .consumeReaction(event.first.id!);
        event.removeAt(0);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.all(16.0),
            child: Container(
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.only(
                          bottom: constraints.maxWidth * 0.90,
                          top: 120,
                        ),
                        child: Column(
                          children: List<Widget>.generate(
                            4,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: FriendLivePostWidget(
                                userEmail: 'moktak072@gmail.com',
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 34, bottom: 34),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "남은 시간",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "00:07",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: IgnorePointer(
                      child: Container(
                        color: Colors.blue,
                        width: 10,
                        height: 10,
                        child: Stack(
                          children: emojiFireWorkManager.fireworkWidgets.values
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  activeResolutionList.when(
                    data: (fetchedActiveResolutionList) {
                      // load first goal statement
                      fetchedActiveResolutionList.fold(
                        (error) => debugPrint(
                            'Error, when fetching active resolution list: $error'),
                        (resolutionList) async {
                          if (resolutionList.isNotEmpty) {
                            // selectedResolutionGoal.value =
                            //     resolutionList.first.goalStatement;
                            resolutionModelList = resolutionList;
                          } else {
                            //
                          }
                        },
                      );

                      return MyLiveWritingWidget(
                        resolutionModel: resolutionModelList.first,
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
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
}

class MyLiveWritingWidget extends StatefulHookConsumerWidget {
  const MyLiveWritingWidget({
    required this.resolutionModel,
    super.key,
  });

  final ResolutionModel resolutionModel;

  @override
  ConsumerState<MyLiveWritingWidget> createState() =>
      _MyLiveWritingWidgetState();
}

class _MyLiveWritingWidgetState extends ConsumerState<MyLiveWritingWidget> {
  final _confirmPostFormKey = GlobalKey<FormState>();
  bool isSubmitted = false;
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    var titleController = useTextEditingController();
    var contentController = useTextEditingController();

    useEffect(
      () {
        titleController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateTitle(titleController.text);
        });
        contentController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateMessage(contentController.text);
        });

        return null;
      },
      [],
    );

    return Align(
      alignment: const Alignment(1, 1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.grey.shade800,
            width: constraints.maxWidth,
            height: constraints.maxWidth * 0.90,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Name"),
                        ),
                        Expanded(child: Container()),
                        Text(widget.resolutionModel.goalStatement),
                      ],
                    ),
                    TextFormField(
                      controller: titleController,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "제목",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.amber,
                      thickness: 2.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: contentController,
                          maxLines: 6,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '본문',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 151,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 14.0,
                                  bottom: 8.0,
                                ),
                                child: Container(
                                  width: 151,
                                  height: 104,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                                  child: GestureDetector(
                                    onTapUp: (details) async {
                                      final pickedFile =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (pickedFile != null) {
                                        setImage(pickedFile);
                                      } else {
                                        debugPrint('이미지 선택안함');
                                      }
                                    },
                                    child: Visibility(
                                      visible: imageFile != null,
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(imageFile?.path ?? ""),
                                        ),
                                      ),
                                      replacement: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("Tap To Add Image"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {}, child: Text("휴식")),
                                  ElevatedButton(
                                    onPressed: () async {
                                      isSubmitted = true;
                                      ConfirmPostModel cf = ConfirmPostModel(
                                        title: titleController.text,
                                        content: contentController.text,
                                        resolutionGoalStatement: widget
                                            .resolutionModel.goalStatement,
                                        resolutionId:
                                            widget.resolutionModel.resolutionId,
                                        imageUrl: '',
                                        recentStrike: 0,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        owner: '',
                                        fan: [],
                                        attributes: {
                                          'has_participated_live': true,
                                          'has_rested': false,
                                        },
                                      );

                                      (await ref.read(
                                        createPostUseCaseProvider,
                                      )(cf))
                                          .fold(
                                        (l) {
                                          debugPrint(
                                            Failure(l.message).toString(),
                                          );
                                        },
                                        (r) => () {},
                                        // showSimpleSnackBar(
                                        //     context,
                                        //     '인증글이 등록되었습니다'),
                                      );
                                    },
                                    child: const Text('완료'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> onSave() async {
    //getAllFanMarkedConfirmPosts();
    ref.read(confirmPostDatasourceProvider).getAllFanMarkedConfirmPosts();
    if (isSubmitted) {
      return;
    }

    if (_confirmPostFormKey.currentState!.validate()) {
      _confirmPostFormKey.currentState!.save();
      isSubmitted = true;
      // onSubmit(titleController.text, contentController.text);
    }
  }

  Future<void> setImage(XFile pickedFile) async {
    setState(() {
      imageFile = pickedFile;
    });
    ref
        .read(
          liveWritingPostRepositoryProvider,
        )
        .updatePostImage(
          pickedFile.path,
        );
  }
}
