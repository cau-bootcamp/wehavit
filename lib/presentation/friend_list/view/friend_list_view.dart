import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
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
    super.didChangeDependencies();
    ref.read(friendListViewModelProvider.notifier).getFriendList();
    ref.read(friendListViewModelProvider.notifier).getAppliedFriendList();
    ref.read(friendListViewModelProvider.notifier).getMyUserDataEntity();
  }

  bool isManagingMode = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(friendListViewModelProvider);
    final provider = ref.read(friendListViewModelProvider.notifier);

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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
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
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FriendListMyProfileWidget(
                    futureUserEntity: viewModel.futureMyUserDataEntity,
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Expanded(
                child: EitherFutureBuilder<List<EitherFuture<UserDataEntity>>>(
                  target: viewModel.futureFriendList,
                  forFail: const FriendListFailPlaceholderWidget(),
                  forWaiting: Container(),
                  mainWidgetCallback: (list) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '내 친구들 (${list.length})',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return FriendListCellWidget(
                                futureUserEntity: list[index],
                                cellState: FriendListCellState.normal,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // in managing mode
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
                    searchCallback: (searchNickname) async {
                      if (searchNickname != null && searchNickname.isNotEmpty) {
                        provider
                            .searchUserByNickname(
                              nickname: searchNickname,
                            )
                            .whenComplete(() => setState(() {}));
                      }
                    },
                  ),
                  EitherFutureBuilder<List<EitherFuture<UserDataEntity>>>(
                    target: viewModel.futureSearchedUserList,
                    forWaiting: Container(),
                    forFail: Container(),
                    mainWidgetCallback: (futureUserList) {
                      return Column(
                        children: List<Widget>.generate(
                          futureUserList.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: FriendListCellWidget(
                              futureUserEntity: futureUserList[index],
                              cellState: FriendListCellState.toApply,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              EitherFutureBuilder<List<EitherFuture<UserDataEntity>>>(
                target: viewModel.futureAppliedUserList,
                forWaiting: Container(),
                forFail: Container(),
                mainWidgetCallback: (futureUserList) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        '새로운 친구 요청 (${futureUserList.length})',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.whWhite,
                        ),
                      ),
                      Column(
                        children: List<Widget>.generate(
                          futureUserList.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: FriendListCellWidget(
                              futureUserEntity: futureUserList[index],
                              cellState: FriendListCellState.applied,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              EitherFutureBuilder<List<EitherFuture<UserDataEntity>>>(
                target: viewModel.futureFriendList,
                forWaiting: Container(),
                forFail: Container(),
                mainWidgetCallback: (futureUserList) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        '내 친구들 (${futureUserList.length})',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.whWhite,
                        ),
                      ),
                      Column(
                        children: List<Widget>.generate(
                          futureUserList.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: FriendListCellWidget(
                              futureUserEntity: futureUserList[index],
                              cellState: FriendListCellState.managing,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
