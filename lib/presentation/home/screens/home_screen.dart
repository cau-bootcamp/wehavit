import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/home/home.dart';
import 'package:wehavit/presentation/reaction/widget/reaction_animation_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeScreen();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = -1;
  int maxIndex = 27;

  static const String dateFormat = 'yyyy년 MM월 dd일';
  static const List<String> weekdayKR = ['월', '화', '수', '목', '금', '토', '일'];

  late final MainViewModel _mainViewModel;
  late final MainViewModelProvider _mainViewModelProvider;

  late final ReactionCameraWidgetModel _reactionCameraWidgetModel;
  late final ReactionCameraWidgetModelProvider
      _reactionCameraWidgetModelProvider;

  Point<double> panPosition = const Point(0, 0);

  bool _initOccurred = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
      ref.read(confirmPostListProvider.notifier).getConfirmPostList(
            DateTime.now().add(Duration(days: maxIndex - selectedIndex)),
          );
    });
    setState(() {
      selectedIndex = maxIndex;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initOccurred) {
      ref.read(confirmPostListProvider.notifier).getConfirmPostList(
            DateTime.now().add(Duration(days: maxIndex - selectedIndex)),
          );

      _mainViewModel = ref.watch(mainViewModelProvider);
      _mainViewModelProvider = ref.read(mainViewModelProvider.notifier);

      _reactionCameraWidgetModel = ref.watch(reactionCameraWidgetModelProvider);
      _reactionCameraWidgetModelProvider =
          ref.read(reactionCameraWidgetModelProvider.notifier);

      await ref
          .read(mainViewModelProvider.notifier)
          .getTodayConfirmPostModelList();

      await _mainViewModelProvider.initializeCamera();

      setAnimationVariables();

      setState(() {});
      _initOccurred = true;
    }
  }

  List<DateTime> generateDatesList() {
    var today = DateTime.now();
    var datesList = List<DateTime>.generate(28, (i) {
      return today.subtract(Duration(days: i));
      // (date.month.toString(), date.day.toString().padLeft(2, '0'));
    });

    return datesList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = generateDatesList();
    var confirmPostList = ref.watch(confirmPostListProvider);

    return Scaffold(
      backgroundColor: CustomColors.whBlack,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    // top bar
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.group,
                            color: CustomColors.whSemiWhite,
                          ),
                          onPressed: () async {
                            context.go(RouteLocation.friendList);
                          },
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: CustomColors.whSemiWhite,
                          ),
                          onPressed: () async {
                            // 알림 센터 뷰
                          },
                        ),
                        TextButton(
                          onPressed: () async {
                            context.go(RouteLocation.myPage);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20,
                            backgroundImage:
                                FirebaseAuth.instance.currentUser?.photoURL !=
                                        null
                                    ? NetworkImage(
                                        FirebaseAuth
                                            .instance.currentUser!.photoURL!,
                                      ) as ImageProvider<Object>?
                                    : const AssetImage(
                                        'path_to_default_image',
                                      ),
                          ),
                        ),
                      ],
                    ),
                    // date
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        width: double.infinity,
                        child: Text(
                          DateFormat(dateFormat).format(DateTime.now()),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: CustomColors.whSemiWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // scroll calendar
                    scrollCalendarWidget(dates),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: CustomColors.whBlack,
                    ),
                    child: Column(
                      children: [
                        confirmPostList.fold(
                            (left) => const Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '데이터를 가져오는데에 실패했어요',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.whWhite,
                                          ),
                                        ),
                                        Text(
                                          '🤖',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.whWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ), (right) {
                          if (right.isNotEmpty) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: right.length,
                                itemBuilder: (context, index) {
                                  return ConfirmPostWidget(
                                    key: UniqueKey(),
                                    model: right[index],
                                    panUpdateCallback: updatePanPosition,
                                    panEndCallback: endOnCapturingPosition,
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '아무도 인증글을 남기지 않은\n조용한 날이네요',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.whWhite,
                                      ),
                                    ),
                                    Text(
                                      '🤫',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.whWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_mainViewModel.isCameraInitialized)
            ReactionCameraWidget(
              cameraController: _mainViewModel.cameraController,
              panPosition: panPosition,
            ),
          const ReactionAnimationWidget(),
        ],
      ),
    );
  }

  Container scrollCalendarWidget(List<DateTime> dates) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.whBlack,
      ),
      height: 70,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 4, right: 4),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // 버튼을 누르면 selectedIndex 가 변경되고, provider를 통해 해당
                    // 날짜의 데이터를 불러온다.
                    setState(() {
                      selectedIndex = index; // 상태 변경
                    });
                    await ref
                        .read(confirmPostListProvider.notifier)
                        .getConfirmPostList(
                          DateTime.now()
                              .add(Duration(days: maxIndex - selectedIndex)),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(47, 70),
                    maximumSize: const Size(47, 70),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: selectedIndex == index
                        ? CustomColors.whYellow // Color for selected button
                        : CustomColors.whYellowDark,
                    elevation: 2,
                    shadowColor: CustomColors.whDarkBlack,
                  ),
                  child: Column(
                    children: [
                      Text(
                        weekdayKR[dates[index].weekday - 1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: selectedIndex == index
                              ? CustomColors.whSelectedTextColor
                              : CustomColors.whUnSelectedTextColor,
                        ),
                      ),
                      Text(
                        dates[index].day.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: selectedIndex == index
                              ? CustomColors.whSelectedTextColor
                              : CustomColors.whUnSelectedTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.whDarkBlack,
                        // blurRadius: 30,
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void setAnimationVariables() {
    _mainViewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _mainViewModel.animation = Tween<double>(begin: 0, end: 140).animate(
      CurvedAnimation(
        parent: _mainViewModel.animationController,
        curve: Curves.linear,
      ),
    );
    _mainViewModel.animationController.value = 1;
  }

  void updatePanPosition(Point<double> position) {
    setState(() {
      panPosition = position;
    });
  }

  Future<void> endOnCapturingPosition(
    Point<double> position,
    String confirmModleId,
  ) async {
    final imageFilePath = await _reactionCameraWidgetModelProvider.capture();
    // 반응 전송 로직 아래에 삽입
    _mainViewModelProvider.sendImageReaction(
      imageFilePath: imageFilePath,
      confirmModleId: confirmModleId,
    );
  }
}
