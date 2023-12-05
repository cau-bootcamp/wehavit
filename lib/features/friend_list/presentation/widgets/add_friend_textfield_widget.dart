import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/friend_list/presentation/providers/add_friend_provider.dart';
import 'package:wehavit/features/friend_list/presentation/providers/friend_list_provider.dart';

class AddFriendTextFieldWidget extends ConsumerWidget {
  const AddFriendTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addFriendProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Container(
        height: 48,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: CustomColors.whYellowDark,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
              ),
              Expanded(
                child: TextFormField(
                  // 추후에 onChanged가 아닌 것으로 바꿀 예정
                  onChanged: (value) {
                    ref.read(addFriendProvider.notifier).setFriendEmail(value);
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    iconColor: CustomColors.whWhite,
                    hintText: '친구 이메일 검색',
                    hintStyle: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 16,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: -8),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(addFriendProvider.notifier).uploadFriendModel().then(
                    (result) {
                      result.fold((failure) {
                        debugPrint(
                            'DEBUG : UPLOAD FAILED - ${failure.message}');
                      }, (success) {
                        ref.read(friendListProvider.notifier).getFriendList();
                      });
                    },
                  );
                },
                style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(CustomColors.whWhite),
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    CustomColors.whYellowDark,
                  ),
                  shape: MaterialStatePropertyAll<CircleBorder>(CircleBorder()),
                ),
                child: const Text('+'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
