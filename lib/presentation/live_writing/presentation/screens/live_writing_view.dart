// ignore_for_file: discarded_futures
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/domain/entities/counter_state/counter_state.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_model.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';
import 'package:wehavit/domain/entities/waiting_entity/waiting_model.dart';
import 'package:wehavit/domain/repositories/live_writing_friend_repository_provider.dart';
import 'package:wehavit/domain/repositories/live_writing_mine_repository_provider.dart';
import 'package:wehavit/presentation/effects/emoji_firework_animation/emoji_firework_manager.dart';
import 'package:wehavit/presentation/live_writing/live_writing.dart';
import 'package:wehavit/presentation/live_writing/presentation/widgets/friend_live_post_widget.dart';
import 'package:wehavit/presentation/live_writing/presentation/widgets/my_live_writing_widget.dart';

import 'package:wehavit/presentation/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';

class LiveWritingView extends StatefulHookConsumerWidget {
  const LiveWritingView({super.key});

  @override
  ConsumerState<LiveWritingView> createState() => _LiveWritingViewState();
}

class _LiveWritingViewState extends ConsumerState<LiveWritingView>
    with SingleTickerProviderStateMixin {
  XFile? imageFile;
  ValueNotifier<bool> isSubmitted = ValueNotifier(false);

  // List<ResolutionModel> resolutionModelList = [];

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

  Map<Key, ShootEmojiWidget> emojiWidgets = {};
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    setAnimationVariables();
  }

  @override
  Widget build(BuildContext context) {
    // Timer Countdown Stream
    final timerStream = useMemoized(
      () => ref.read(waitingProvider.notifier).getWritingTimerStream(),
    );
    final timerStreamSnapshot = useStream(timerStream);

    final timerCounterState = ref.watch(waitingProvider);

    final activeResolutionList = ref.watch(activeResolutionListProvider);

    final friendEmailsFuture = useMemoized(() => getVisibleFriends(ref));
    final friendEmailsSnapshot = useFuture<List<String>>(friendEmailsFuture);

    final reactionStream = useMemoized(() => reactionNotificationStream(ref));
    // ignore: unused_local_variable
    final reactionSnapshot = useStream<List<ReactionModel>>(reactionStream);

    final resolutionModelList = useState(<ResolutionModel>[]);

    // auto dispose을 방지하기 위해 watch 삽입
    final _ = ref.watch(liveWritingFriendRepositoryProvider);

    useEffect(
      () {
        debugPrint('timerCounterState.counterStateEnum: '
            '${timerCounterState.counterStateEnum}');

        if (timerCounterState.counterStateEnum == CounterStateEnum.timeOver) {
          context.go(RouteLocation.home);
        }
        return null;
      },
      [timerCounterState.counterStateEnum],
    );

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
      body: GestureDetector(
        onTapUp: (details) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomColors.whDarkBlack,
                CustomColors.whYellowDark,
                CustomColors.whYellow,
              ],
              stops: [0.3, 0.8, 1.2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: FriendLivePostWidget(
                                  userEmail: friendEmailsSnapshot.data![index],
                                  sendReactionCallback: sendEmojiReaction,
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
                      child: Column(
                        children: [
                          const Text(
                            '남은 시간',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          Text(
                            timerStreamSnapshot.data ?? '',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.whWhite,
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
                            children: emojiFireWorkManager
                                .fireworkWidgets.values
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
                        color: CustomColors.whWhite,
                      ),
                    ),
                  ],
                ),
              ),
              activeResolutionList.when(
                data: (fetchedActiveResolutionList) {
                  // List<ResolutionModel> resolutionModelList = [];
                  // load first goal statement
                  fetchedActiveResolutionList.fold(
                    (error) {
                      debugPrint(
                        'Error, when fetching active resolution list: $error',
                      );
                    },
                    (resolutionList) async {
                      if (resolutionList.isNotEmpty) {
                        // selectedResolutionGoal.value =
                        //     resolutionList.first.goalStatement;
                        final sortedList = resolutionList
                          ..sort((a, b) => a.startDate.compareTo(b.startDate));
                        resolutionModelList.value = sortedList;
                      }
                    },
                  );

                  if (resolutionModelList.value.isEmpty) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      child: const Center(
                        child: Text(
                          '친구들과 함께 인증글을 작성하기\n'
                          '위해서는 목표를 추가해주세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.whSemiWhite,
                          ),
                        ),
                      ),
                    );
                  }

                  List<Widget> writingCellList = resolutionModelList.value.map(
                    (model) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyLiveWritingWidget(
                          resolutionModel: model,
                        ),
                      );
                    },
                  ).toList();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Align(
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
                            children:
                                writingCellList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
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
                    ),
                  );
                  // return
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
              ),
              Container(
                constraints: const BoxConstraints.expand(),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: emojiWidgets.values.toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setAnimationVariables() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween<double>(begin: 0, end: 140).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
    animationController.value = 1;
  }

  Future<void> sendEmojiReaction(
    int emojiNo,
    String userEmail,
    TapUpDetails detail,
    // Function(UniqueKey key) disposeWidget,
  ) async {
    shootEmoji(
      emojiNo,
      detail,
    );

    final sendResult = await ref
        .read(liveWritingFriendRepositoryProvider)
        .sendReactionToTargetFriend(
          userEmail,
          ReactionModel(
            complimenterUid: '',
            reactionType: ReactionType.emoji.index,
            emoji: {'t${emojiNo.toString().padLeft(2, '0')}': 1},
          ),
        );
    sendResult.fold(
      (l) => debugPrint('send emoji to $userEmail failed'),
      (r) => debugPrint('send emoji to $userEmail success'),
    );
  }

  void shootEmoji(
    int emojiNo,
    TapUpDetails detail,
    // void Function(UniqueKey key) disposeWidget,
  ) {
    return setState(
      () {
        final animationWidgetKey = UniqueKey();

        emojiWidgets.addEntries(
          {
            animationWidgetKey: ShootEmojiWidget(
              key: animationWidgetKey,
              emojiIndex: emojiNo,
              currentPos: Point(
                detail.globalPosition.dx,
                detail.globalPosition.dy - 25,
              ),
              targetPos: Point(
                MediaQuery.of(context).size.width / 2,
                150,
              ),
              disposeWidgetFromParent: (UniqueKey key) {
                emojiWidgets.remove(key);
              },
            ),
          }.entries,
        );
      },
    );
  }
}
