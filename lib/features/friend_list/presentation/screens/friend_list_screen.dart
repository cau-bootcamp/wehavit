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
    var v_friendListProvider = ref.watch(friendListProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(128),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(),
          ],
        ),
      ),
      body :
      v_friendListProvider.fold(
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
                      height: 150,
                    );
              }
            },
          ),
        ),
      ) as Widget,
    );
  }
}
