import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
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
      FriendListScreenState();
}

class FriendListScreenState extends ConsumerState<FriendListView> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    ref.read(friendListViewModelProvider.notifier).getMyUserDataEntity();
    ref.read(friendListViewModelProvider.notifier).getAppliedFriendList();
    ref
        .read(friendListViewModelProvider.notifier)
        .getFriendList()
        .whenComplete(() => setState(() {}));
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
        trailingIconBadgeCount:
            isManagingMode ? null : viewModel.appliedFutureUserList?.length,
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
                // 수정 필요함!
                onPressed: () async {
                  await ref.read(logOutUseCaseProvider).call();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/entrance');
                  }
                },
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
              if (viewModel.friendFutureUserList == null)
                const FriendListFailPlaceholderWidget()
              else
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '내 친구들 (${viewModel.friendFutureUserList!.length})',
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
                          itemCount: viewModel.friendFutureUserList!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: FriendListCellWidget(
                                futureUserEntity:
                                    viewModel.friendFutureUserList![index],
                                cellState: FriendListCellState.normal,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // in managing mode
          // child: Container(),
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
                  if (viewModel.searchedFutureUserList == null)
                    Container()
                  else
                    Column(
                      children: List<Widget>.generate(
                        viewModel.searchedFutureUserList!.length,
                        (index) => FriendListCellWidget(
                          futureUserEntity:
                              viewModel.searchedFutureUserList![index],
                          cellState: FriendListCellState.toApply,
                        ),
                      ),
                    ),
                ],
              ),
              if (viewModel.appliedFutureUserList == null ||
                  viewModel.appliedFutureUserList!.isEmpty)
                Container()
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      '새로운 친구 요청 (${viewModel.appliedFutureUserList!.length})',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whWhite,
                      ),
                    ),
                    Column(
                      children: List<Widget>.generate(
                        viewModel.appliedFutureUserList!.length,
                        (index) => FriendListCellWidget(
                          futureUserEntity:
                              viewModel.appliedFutureUserList![index],
                          cellState: FriendListCellState.applied,
                        ),
                      ),
                    ),
                  ],
                ),
              if (viewModel.friendFutureUserList == null ||
                  viewModel.friendFutureUserList!.isEmpty)
                Container()
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      '내 친구들 (${viewModel.friendFutureUserList!.length})',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whWhite,
                      ),
                    ),
                    Column(
                      children: List<Widget>.generate(
                        viewModel.friendFutureUserList!.length,
                        (index) => FriendListCellWidget(
                          futureUserEntity:
                              viewModel.friendFutureUserList![index],
                          cellState: FriendListCellState.managing,
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
