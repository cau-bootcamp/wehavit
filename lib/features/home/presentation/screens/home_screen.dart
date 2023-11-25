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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
      ref
          .read(confirmPostListProvider.notifier)
          .getConfirmPostList(selectedIndex);
      setState(() {
        selectedIndex = 27;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(128),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black87,
              title: Text(
                DateFormat(dateFormat).format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.group, color: Colors.white),
                  onPressed: () async {
                    context.go(RouteLocation.friendList);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () async {
                    // 알림 센터 뷰
                  },
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () async {
                        // 버튼을 누르면 selectedIndex 가 변경되고, provider를 통해 해당
                        // 날짜의 데이터를 불러온다.
                        selectedIndex = index;
                        await ref
                            .read(confirmPostListProvider.notifier)
                            .getConfirmPostList(selectedIndex);
                      },
                      style: TextButton.styleFrom(
                        // Change the background color to indicate selection
                        backgroundColor: selectedIndex == index
                            ? Colors.orange
                            : Colors.grey,
                      ),
                      child: Align(
                        child: Text(
                          '${dates[index].$1}\n${dates[index].$2}',
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.black,
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
        decoration: const BoxDecoration(
          color: Colors.black87,
        ),
        child: Column(
          children: [
            confirmPostList.fold(
              (left) => null,
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
            ) as Widget,
          ],
        ),
      ), //
    );
  }
}
