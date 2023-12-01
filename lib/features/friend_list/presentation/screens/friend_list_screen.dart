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
            color: CustomColors.whBlack,
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
            const AddFriendTextFieldWidget(),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                color: CustomColors.whBlack,
              ),
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: CustomColors.whYellow,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(12),
                            child: CircleAvatar(
                              radius: 32,
                              foregroundImage: NetworkImage(
                                currentUser?.photoURL ?? 'DEBUG_URL',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentUser?.displayName ?? 'DEBUG_NO_NAME',
                                  style: TextStyle(
                                      color: CustomColors.whWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currentUser?.email ?? 'DEBUG_UserID',
                                  style: TextStyle(color: CustomColors.whWhite),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
//            Column(
//              children: [
//                SizedBox(
//                  width: 200,
//                  child: FilledButton(
//                    onPressed: () async {
//                      await ref
//                          .read(friendListProvider.notifier)
//                          .getFriendList();
//                    },
//                    child: const Text('친구 목록 새로고침'),
//                  ),
//                ),
//              ],
//            ),
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
