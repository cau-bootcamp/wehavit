import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/presentation/widget/confirm_post_widget.dart';

import '../provider/conform_post_list_provider.dart';

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

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = -1;

  static const String dateFormat = 'yyyy년 MM월 dd일';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
      ref
          .read(confirmPostListProvider.notifier)
          .getConfirmPostList(selectedIndex);
    });
    setState(() {
      selectedIndex = 27;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    ref
        .read(confirmPostListProvider.notifier)
        .getConfirmPostList(selectedIndex);
  }

  List<(String, String)> generateDatesList() {
    var today = DateTime.now();
    var datesList = List<(String, String)>.generate(28, (i) {
      var date = today.subtract(Duration(days: i));
      return (date.month.toString(), date.day.toString().padLeft(2, '0'));
    });

    return datesList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> dates = generateDatesList();
    var confirmPostList = ref.watch(confirmPostListProvider);

    return Scaffold(
      backgroundColor: CustomColors.whBlack,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(128),
        child: Column(
          children: [
            AppBar(
              foregroundColor: CustomColors.whBlack,
              backgroundColor: CustomColors.whBlack,
              title: Text(
                DateFormat(dateFormat).format(DateTime.now()),
                style: const TextStyle(
                  color: CustomColors.whSemiWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.group,
                    color: CustomColors.whSemiWhite,
                  ),
                  onPressed: () async {
                    context.go(RouteLocation.friendList);
                  },
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
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                color: CustomColors.whBlack,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 4, right: 4),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(2),
                    child: TextButton(
                      onPressed: () async {
                        // 버튼을 누르면 selectedIndex 가 변경되고, provider를 통해 해당
                        // 날짜의 데이터를 불러온다.
                        setState(() {
                          selectedIndex = index; // 상태 변경
                        });
                        await ref
                            .read(confirmPostListProvider.notifier)
                            .getConfirmPostList(selectedIndex);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18), // 패딩 조절
                        minimumSize: const Size(0, 0), // 최소 크기 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40), // 모서리 둥글게
                        ),
                        // Change the background color to indicate selection
                        backgroundColor: selectedIndex == index
                            ? CustomColors.whYellow
                            : CustomColors.whSemiBlack,
                      ),
                      child: Align(
                        child: Text(
                          '${dates[index].$1}\n${dates[index].$2}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == index
                                ? CustomColors.whSemiBlack
                                : CustomColors.whSemiWhite,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ), // 날짜들
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
          color: CustomColors.whBlack,
        ),
        child: Column(
          children: [
            confirmPostList.fold(
              (left) => Container(),
              (right) => Expanded(
                child: ListView.builder(
                  itemCount: right.length,
                  itemBuilder: (context, index) {
                    return ConfirmPostWidget(
                      key: ValueKey(right[index].userName),
                      model: right[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ), //
    );
  }
}
