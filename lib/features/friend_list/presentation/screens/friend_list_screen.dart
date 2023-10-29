import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FriendListScreen extends ConsumerWidget {
  const FriendListScreen({super.key});

  static FriendListScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const FriendListScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(128),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(),
            _myPanel('나', '오늘도 화이팅이에요!'),
          ],
        ),
      ),
      body: ListView(
        children: [
          _friendPanel('kyusulee', '이제는 습관이 되어가고 있어요'),
          _friendPanel('SungminPark', '역시 꾸준을 이기진 못하죠!', progress: 3),
          _friendPanel('JoohyungCho', '천천히 앞으로 나아가는 중'),
          _friendPanel('Cola', '잠시 휴식중,,', progress: 2),
          _friendPanel('Coca', '화이팅! 힘을 내요'),
          _friendPanel('WWW', '집에 가고 싶어요'),
        ],
      ),
    );
  }

  Widget _myPanel(String name, String message, {int progress = 0}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(''),
      ),
      title: Text(name),
      subtitle: Text(message),
      //친구 링크 생성하는 버튼 추가
      trailing: IconButton(icon: const Icon(Icons.link), color: Colors.black87, onPressed: (){},),
    );
  }

  Widget _friendPanel(String name, String message, {int progress = 0}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(''),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: _buildProgressBar(progress),
    );
  }

  Widget _buildProgressBar(int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) => index < count ? _activeBar() : _inactiveBar()),
    );
  }

  Widget _activeBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      width: 30,
      height: 10,
      color: Colors.blue,
    );
  }

  Widget _inactiveBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      width: 30,
      height: 10,
      color: Colors.grey,
    );
  }
}
