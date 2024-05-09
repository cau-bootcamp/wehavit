import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/friend_list/friend_list.dart';
import 'package:wehavit/presentation/presentation.dart';

class FriendListScreen extends ConsumerStatefulWidget {
  const FriendListScreen({super.key});

  static FriendListScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const FriendListScreen();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListScreen> {
  @override
  Future<void> didChangeDependencies() async {
    ref.read(friendListProvider.notifier).getFriendList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var friendList = ref.watch(friendListProvider);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(title: '친구 목록'),
      body: SafeArea(
        child: Column(
          children: [
            const AddFriendTextFieldWidget(),
            // 내 프로필
            // MyProfile(currentUser: currentUser),
            // 친구 수 표시
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 16, left: 16, bottom: 4),
              child: Text(
                '내 친구들(${friendList.fold((l) => 0, (r) => r.length)})',
                textAlign: TextAlign.left,
                style: const TextStyle(color: CustomColors.whWhite),
              ),
            ),
            // 친구 리스트
            friendList.fold(
              (left) => Placeholder(),
              (right) => Expanded(
                child: ListView.builder(
                  itemCount: right.length,
                  itemBuilder: (context, index) {
                    return FriendElementWidget(
                      key: ValueKey(right[index].userEmail),
                      model: right[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
