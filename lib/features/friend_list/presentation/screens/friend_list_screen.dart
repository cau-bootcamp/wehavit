import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/features/friend_list/presentation/widgets/friend_element_widget.dart';
import 'package:wehavit/features/friend_list/presentation/providers/friend_list_provider.dart';

class FriendListScreen extends ConsumerWidget {
  const FriendListScreen({super.key});

  static FriendListScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const FriendListScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = FirebaseAuth.instance.currentUser;
    var vFriendListProvider = ref.watch(friendListProvider);

    return Scaffold(
      appBar: AppBar(),
      body : Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 40,
                    foregroundImage:
                    NetworkImage(currentUser?.photoURL ?? 'DEBUG_URL'),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentUser?.displayName ?? 'DEBUG_NONAME'),
                    Text(currentUser?.email ?? 'DEBUG_UserID'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: IconButton(icon: const Icon(Icons.add), color: Colors.black87, onPressed: (){},),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: FilledButton(
                    onPressed: () async {
                      await ref
                          .read(friendListProvider.notifier)
                          .getFriendList();
                    },
                    child: const Text('친구 목록 보기'),
                  ),
                ),
              ),
            ],
          ),
          vFriendListProvider.fold(
                (left) => null,
                (right) => Expanded(
              child: ListView.builder(
                itemCount: right.length + 1,
                itemBuilder: (context, index) {
                  if (index < right.length) {
                    return FriendElementWidget(model: right[index]);
                  } else {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(border: Border.all()),
                      height: 100,
                    );
                  }
                },
              ),
            ),
          ) as Widget,
        ],
      ),
    );
  }
}
