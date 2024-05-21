import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
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

  bool isManagingMode = false;

  @override
  Widget build(BuildContext context) {
    var friendList = ref.watch(friendListProvider);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '친구 목록',
        trailingTitle: isManagingMode ? '완료' : null,
        trailingIcon: isManagingMode ? null : Icons.manage_accounts_outlined,
        trailingIconBadgeCount: isManagingMode ? null : 3,
        trailingAction: () {
          setState(() {
            isManagingMode = !isManagingMode;
          });
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: isManagingMode,
          replacement: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  print("HE");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  backgroundColor: CustomColors.whGrey,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: CustomColors.whYellow,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyProfileWidget(
                        futureUserEntity: Future.delayed(
                          Duration(seconds: 1),
                          () => right(UserDataEntity.dummyModel),
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset(
                            CustomIconImage.linkIcon,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "복사하기",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.whWhite,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  '내 친구들 (17)',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                  ),
                ),
              ),
              // 친구 리스트
              friendList.fold(
                (left) => const FriendListFailPlaceholderWidget(),
                (v) => Expanded(
                  child: ListView.builder(
                    itemCount: v.length,
                    itemBuilder: (context, index) {
                      return FriendListCellWidget(
                        futureUserEntity: Future(
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
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '친구 신청',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  FriendListTextFieldWidget(
                    searchCallback: (searchNickname) {
                      // viewModel 통해 search 하기
                      print(searchNickname);
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  FriendListCellWidget(
                    futureUserEntity: Future.delayed(
                      Duration(seconds: 2),
                      () => right(UserDataEntity.dummyModel),
                    ),
                    cellState: FriendListCellState.toApply,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '새로운 친구 요청',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  Column(
                    children: List<Widget>.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: FriendListCellWidget(
                          futureUserEntity: Future.delayed(
                            const Duration(seconds: 2),
                            () => right(UserDataEntity.dummyModel),
                          ),
                          cellState: FriendListCellState.applied,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 친구들',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  Column(
                    children: List<Widget>.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: FriendListCellWidget(
                          futureUserEntity: Future.delayed(
                            const Duration(seconds: 2),
                            () => right(UserDataEntity.dummyModel),
                          ),
                          cellState: FriendListCellState.managing,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
