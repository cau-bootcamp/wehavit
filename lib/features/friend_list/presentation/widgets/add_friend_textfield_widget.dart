import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/friend_list/presentation/providers/add_friend_provider.dart';
import 'package:wehavit/features/friend_list/presentation/providers/friend_list_provider.dart';

class AddFriendTextFieldWidget extends ConsumerWidget {
  const AddFriendTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addFriendProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 300,
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              onChanged: (value) {
                ref.read(addFriendProvider.notifier).setFriendEmail(value);
              },
              decoration: const InputDecoration(
                hintText: 'Enter Friend ID',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              ref.read(addFriendProvider.notifier).uploadFriendModel().then(
                (result) {
                  result.fold((failure) {
                    debugPrint('DEBUG : UPLOAD FAILED - ${failure.message}');
                  }, (success) {
                    ref.read(friendListProvider.notifier).getFriendList();
                  });
                },
              );
            },
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
