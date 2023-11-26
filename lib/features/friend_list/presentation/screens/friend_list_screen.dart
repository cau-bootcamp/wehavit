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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black54),
            // 일단 임시로 검은색과 홈 아이콘으로 처리하였음.
            onPressed: () async {
              context.go(RouteLocation.home);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          foregroundImage: NetworkImage(
                            currentUser?.photoURL ?? 'DEBUG_URL',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentUser?.displayName ?? 'DEBUG_NO_NAME'),
                              Text(currentUser?.email ?? 'DEBUG_UserID'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
// TODO: 링크로 친구 추가하기 추후에.
//                  Container(
//                    alignment: Alignment.centerRight,
//                    margin: const EdgeInsets.only(right: 8.0),
//                    child: IconButton(
//                      icon: const Icon(Icons.link),
//                      color: Colors.black87,
//                      onPressed: () {},
//                    ),
//                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      await ref
                          .read(friendListProvider.notifier)
                          .getFriendList();
                    },
                    child: const Text('친구 목록 새로고침'),
                  ),
                ),
                const AddFriendTextFieldWidget(),
              ],
            ),
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
