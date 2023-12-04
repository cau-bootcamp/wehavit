// ignore_for_file: discarded_futures

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/effects/emoji_firework_animation/emoji_firework_manager.dart';
import 'package:wehavit/features/live_writing/live_writing.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_post_widget.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/repository/user_model_fetch_repository_provider.dart';

class LiveWritingView extends StatefulHookConsumerWidget {
  const LiveWritingView({super.key});

  @override
  ConsumerState<LiveWritingView> createState() => _LiveWritingViewState();
}

class _LiveWritingViewState extends ConsumerState<LiveWritingView> {
  XFile? imageFile;
  ValueNotifier<bool> isSubmitted = ValueNotifier(false);
  late List<ResolutionModel> resolutionModelList;

  int _current = 0;
  final CarouselController _controller = CarouselController();

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
      EmojiFireWorkManager(emojiAmount: 10);

  @override
  Widget build(BuildContext context) {
    final activeResolutionList = ref.watch(activeResolutionListProvider);

    final friendEmailsFuture = useMemoized(() => getVisibleFriends(ref));
    final friendEmailsSnapshot = useFuture<List<String>>(friendEmailsFuture);

    final reactionStream = useMemoized(() => reactionNotificationStream(ref));
    // ignore: unused_local_variable
    final reactionSnapshot = useStream<List<ReactionModel>>(reactionStream);

    // auto dispose을 방지하기 위해 watch 삽입
    final _ = ref.watch(liveWritingFriendRepositoryProvider);

    useEffect(
      () {
        reactionStream.listen((event) async {
          if (event.isNotEmpty) {
            List<int> sampledEmojiList = List<int>.generate(15, (index) => 0);
            event.first.emoji.forEach((key, value) {
              sampledEmojiList[int.parse(key.substring(1, 3))] = value;
            });
            emojiFireWorkManager.addFireworkWidget(
              offset: const Offset(0, 0),
              emojiReactionCountList: sampledEmojiList,
            );

            await ref
                .read(liveWritingPostRepositoryProvider)
                .consumeReaction(event.first.id!);
            event.removeAt(0);
          }
        });

        return;
      },
      [],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.only(
                        bottom: 350,
                        top: 120,
                      ),
                      child: Column(
                        children: List<Widget>.generate(
                          friendEmailsSnapshot.data?.length ?? 0,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: FriendLivePostWidget(
                              userEmail: friendEmailsSnapshot.data![index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 34, bottom: 34),
                  width: double.infinity,
                  child: const Column(
                    children: [
                      Text(
                        '남은 시간',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '00:07',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IgnorePointer(
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Stack(
                        children: emojiFireWorkManager.fireworkWidgets.values
                            .toList(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ],
            ),
          ),
          activeResolutionList.when(
            data: (fetchedActiveResolutionList) {
              // load first goal statement
              fetchedActiveResolutionList.fold(
                (error) => debugPrint(
                  'Error, when fetching active resolution list: $error',
                ),
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

              List<Widget> writingCellList = resolutionModelList.map(
                (model) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MyLiveWritingWidget(
                      resolutionModel: model,
                    ),
                  );
                },
              ).toList();

              return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    CarouselSlider(
                      items: writingCellList,
                      carouselController: _controller,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 330,
                        viewportFraction: 0.9,
                        // enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: writingCellList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                _current == entry.key ? 0.9 : 0.4,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
              // return
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
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
  late EitherFuture<UserModel> myUserModel;
  XFile? imageFile;
  String imageUrl = '';
  bool isLoadingImage = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    myUserModel = ref
        .read(userModelFetchRepositoryProvider)
        .fetchUserModelFromId(FirebaseAuth.instance.currentUser!.uid);
  }

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

    bool isSubmittable() {
      return !(titleController.text == '' ||
          contentController.text == '' ||
          imageFile == null ||
          isLoadingImage == true);
    }

    return Align(
      alignment: const Alignment(1, 1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.grey.shade800,
            width: constraints.maxWidth,
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                        future: myUserModel,
                        builder: (context, snapshot) {
                          Widget subwidget;
                          if (snapshot.hasData) {
                            subwidget = snapshot.data!.fold(
                              (l) => Container(),
                              (r) => CircleAvatar(
                                // radius: 32,
                                foregroundImage: NetworkImage(r.imageUrl),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            subwidget = const Placeholder();
                          } else {
                            subwidget = const CircularProgressIndicator();
                          }
                          return SizedBox(
                            width: 64,
                            height: 64,
                            child: subwidget,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          FirebaseAuth.instance.currentUser!.displayName!,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(widget.resolutionModel.goalStatement),
                    ],
                  ),
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '제목',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Divider(
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
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '본문',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
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
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTapUp: (details) async {
                                    if (!isSubmitted) {
                                      final pickedFile =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (pickedFile != null) {
                                        isLoadingImage = true;
                                        imageUrl = await setImage(pickedFile);
                                        isLoadingImage = false;
                                      } else {
                                        debugPrint('이미지 선택안함');
                                      }
                                    }
                                  },
                                  child: Visibility(
                                    visible: imageFile != null,
                                    replacement: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text('Tap To Add Image'),
                                      ),
                                    ),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(imageFile?.path ?? ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !isSubmitted,
                              replacement: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isSubmitted = false;
                                  });
                                  // 다시 편집 상태로 돌아가기
                                },
                                child: const Text('수정'),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (isSubmittable()) {
                                        setState(() {
                                          isSubmitted = true;
                                        });

                                        ConfirmPostModel cf = ConfirmPostModel(
                                          title: titleController.text,
                                          content: contentController.text,
                                          resolutionGoalStatement: widget
                                              .resolutionModel.goalStatement,
                                          resolutionId: widget
                                              .resolutionModel.resolutionId,
                                          imageUrl: imageUrl,
                                          recentStrike: 0,
                                          createdAt: DateTime.now(),
                                          updatedAt: DateTime.now(),
                                          owner: '',
                                          fan: [],
                                          attributes: {
                                            'has_participated_live': true,
                                            'has_rested': true,
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
                                        );
                                      } else {
                                        // 제출할 수 없음
                                        debugPrint(
                                          '제목, 내용, 사진이 모두 입력되지 않아 저장하지 않음',
                                        );
                                      }
                                    },
                                    child: Text(isLoadingImage ? '처리중' : '휴식'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (isSubmittable()) {
                                        setState(() {
                                          isSubmitted = true;
                                        });
                                        ConfirmPostModel cf = ConfirmPostModel(
                                          title: titleController.text,
                                          content: contentController.text,
                                          resolutionGoalStatement: widget
                                              .resolutionModel.goalStatement,
                                          resolutionId: widget
                                              .resolutionModel.resolutionId,
                                          imageUrl: imageUrl,
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
                                        );
                                      } else {
                                        // 제출할 수 없음
                                        debugPrint(
                                          '제목, 내용, 사진이 모두 입력되지 않아 저장하지 않음',
                                        );
                                      }
                                    },
                                    child: Text(isLoadingImage ? '처리중' : '완료'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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

  Future<String> setImage(XFile pickedFile) async {
    setState(() {
      imageFile = pickedFile;
    });
    return ref
        .read(
          liveWritingPostRepositoryProvider,
        )
        .updatePostImage(
          pickedFile.path,
        );
  }
}
