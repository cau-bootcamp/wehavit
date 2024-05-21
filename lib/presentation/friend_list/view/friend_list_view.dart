import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/friend_list/friend_list.dart';
import 'package:wehavit/presentation/friend_list/view/view.dart';
import 'package:wehavit/presentation/presentation.dart';

class FriendListView extends ConsumerStatefulWidget {
  const FriendListView({super.key});

  static FriendListView builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const FriendListView();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListView> {
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
        minimum: const EdgeInsets.symmetric(horizontal: 16),
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
              (left) => const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '친구들에 대한 정보를\n불러오지 못했어요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.whWhite,
                      ),
                    ),
                    Text(
                      '😭',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.whWhite,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              (v) => Expanded(
                child: ListView.builder(
                  itemCount: v.length,
                  itemBuilder: (context, index) {
                    return FriendListCellWidget(
                      futureUserEntity: Future.delayed(
                        const Duration(seconds: 2),
                        () => right(v[index]),
                      ),
                      cellState: FriendListCellState.normal,
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
