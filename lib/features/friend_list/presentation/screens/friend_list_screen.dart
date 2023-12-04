import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/friend_list/presentation/providers/friend_list_provider.dart';
import 'package:wehavit/features/friend_list/presentation/widgets/add_friend_textfield_widget.dart';
import 'package:wehavit/features/friend_list/presentation/widgets/friend_element_widget.dart';

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
    var currentUser = FirebaseAuth.instance.currentUser;
    var friendList = ref.watch(friendListProvider);

    return Scaffold(
      backgroundColor: CustomColors.whBlack,
      appBar: AppBar(
        backgroundColor: CustomColors.whBlack,
        actions: [
          IconButton(
            color: CustomColors.whWhite,
            icon: const Icon(Icons.home, color: CustomColors.whSemiWhite),
            onPressed: () async {
              context.go(RouteLocation.home);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const AddFriendTextFieldWidget(),
            // 내 프로필
            MyProfile(currentUser: currentUser),
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
              (left) => null,
              (right) => Expanded(
                child: ListView.builder(
                  itemCount: right.length,
                  itemBuilder: (context, index) {
                    return FriendElementWidget(
                      key: ValueKey(right[index].friendEmail),
                      model: right[index],
                    );
                  },
                ),
              ),
            ) as Widget,
          ],
        ),
      ),
    );
  }
}
