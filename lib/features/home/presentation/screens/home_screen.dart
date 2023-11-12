import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(126),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.black87,
              title: Text('2023년 10월 2일', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              actions: [
//                IconButton(
//                    icon: Icon(Icons.group, color: Colors.white),
//                    onPressed: () {
//                      Navigator.push(
//                          context, MaterialPageRoute(builder: (context) => FriendsList()));
//                    }),
                IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {}),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      backgroundColor: (index == 6) ? Colors.purple : Colors.grey,
                      child: Text(
                        '${25 + index}',
                        style: TextStyle(color: Colors.white),
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
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: ListView(
          children: [
            // Calender view with days
            Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                child: Column(
                  children: [
                    _feedBlock(
                      '이규성',
                      '캡스톤 열심히 하기',
                      '31번째!',
                      '오늘은 개발 시작하는 날!!😄 뷰 깎는거 꽤나 재밌네, 문명의 이기를 이용하여 열심히 만들어 보겠어.... ',
                      'https://my-media.apjonlinecdn.com/magefan_blog/5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                    ),
                    _feedBlock(
                      '이규성',
                      '캡스톤 열심히 하기',
                      '31번째!',
                      '오늘은 개발 시작하는 날!!😄 뷰 깎는거 꽤나 재밌네, 문명의 이기를 이용하여 열심히 만들어 보겠어.... ',
                      'https://my-media.apjonlinecdn.com/magefan_blog/5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                    ),
                    _feedBlock(
                      '이규성',
                      '캡스톤 열심히 하기',
                      '31번째!',
                      '오늘은 개발 시작하는 날!!😄 뷰 깎는거 꽤나 재밌네, 문명의 이기를 이용하여 열심히 만들어 보겠어.... ',
                      'https://my-media.apjonlinecdn.com/magefan_blog/5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                    ),
                    _feedBlock(
                      '고주형',
                      '클린 아키텍쳐 공부',
                      '열심히 공부중',
                      '화이팅,,, 화이팅,,,,',
                      'https://my-media.apjonlinecdn.com/magefan_blog/5_Components_Of_A_Computer_And_Their_Benefits.jpg',
                    ),
                  ],
                )
            ), //
          ],
        ),
      ),
    );
  }
}

Widget _feedBlock(
    String name, String badge, String title, String message, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Text(name[0]),
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                  ],
                ), //icon, name
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ), //goal name
              ],
            ),
            SizedBox(height: 10),
            Text(title,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            //title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 150,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        strutStyle: StrutStyle(fontSize: 16.0),
                        text: TextSpan(
                          text: message,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 150,
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(Icons.message, color: Colors.grey),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.send, color: Colors.grey), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.flash_on, color: Colors.yellow),
                    onPressed: () {}),
              ],
            ),
            Divider(color: Colors.grey[700]),
          ],
        ),
      ),
    ),
  );
}