import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeScreen();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String dateFormat = 'yyyy년 MM월 dd일';
    List<(String, String)> generateDatesList() {
      var today = DateTime.now();
      var datesList = List<(String, String)>.generate(30, (i) {
        var date = today.subtract(Duration(days: i));
        return (date.month.toString(), date.day.toString().padLeft(2, '0'));
      });

      return datesList.reversed.toList();
    }

    final List<(String, String)> dates = generateDatesList();
    final ScrollController scrollController = ScrollController();
    int selectedIndex = 29;

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
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () {},
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
        child: ListView(
          children: [
            // Calender view with days
            Container(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  _feedBlock(
                    '이규성',
                    '캡스톤 열심히 하기',
                    '31번째!',
                    '오늘은 개발 시작하는 날!!😄 뷰 깎는거 꽤나 재밌네, 문명의 이기를 이용하여 '
                        '열심히 만들어 보겠어.... ',
                    'https://my-media.apjonlinecdn.com/magefan_blog/'
                        '5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                  ),
                  _feedBlock(
                    '이규성',
                    '캡스톤 열심히 하기',
                    '31번째!',
                    '오늘은 개발 시작하는 날!!😄 뷰 깎는거 꽤나 재밌네, 문명의 이기를 '
                        '이용하여 열심히 만들어 보겠어.... ',
                    'https://my-media.apjonlinecdn.com/magefan_blog/'
                        '5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                  ),
                  _feedBlock(
                    '이규성',
                    '캡스톤 열심히 하기',
                    '31번째!',
                    '오늘은 개발 시작하는 날!!😄 뷰 깎는거 꽤나 재밌네, 문명의 이기를 이용하여 '
                        '열심히 만들어 보겠어.... ',
                    'https://my-media.apjonlinecdn.com/magefan_blog/'
                        '5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                  ),
                  _feedBlock(
                    '고주형',
                    '클린 아키텍쳐 공부',
                    '열심히 공부중',
                    '화이팅,,, 화이팅,,,,',
                    'https://my-media.apjonlinecdn.com/magefan_blog/'
                        '5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                  ),
                ],
              ),
            ), //
          ],
        ),
      ),
    );
  }
}

// 파일 분리 예정. model도 짜야 함.
Widget _feedBlock(
  String name,
  String badge,
  String title,
  String message,
  String imageUrl,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(name[0]),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ), //icon, name
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ), //goal name
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            //title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 150,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        strutStyle: const StrutStyle(fontSize: 16.0),
                        text: TextSpan(
                          text: message,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.message, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.flash_on, color: Colors.yellow),
                  onPressed: () {},
                ),
              ],
            ),
            Divider(color: Colors.grey[700]),
          ],
        ),
      ),
    ),
  );
}
