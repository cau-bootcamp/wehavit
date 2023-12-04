// ignore_for_file: discarded_futures
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/features/effects/emoji_firework_animation/emoji_firework_manager.dart';
import 'package:wehavit/features/live_writing/live_writing.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/friend_live_post_widget.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/my_live_writing_widget.dart';
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
