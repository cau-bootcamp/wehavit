import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';

class FriendListView extends ConsumerStatefulWidget {
  const FriendListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FrinedListViewState();
}

class FrinedListViewState extends ConsumerState<FriendListView> {
  @override
  void initState() {
    super.initState();

    unawaited(
      ref.read(friendListViewModelProvider.notifier).getMyUserDataEntity(),
    );
    unawaited(
      ref
          .read(friendListViewModelProvider.notifier)
          .getAppliedFriendList()
          .whenComplete(() => setState(() {})),
    );
    unawaited(
      ref
          .read(friendListViewModelProvider.notifier)
          .getFriendList()
          .whenComplete(() => setState(() {})),
    );
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
            if (isManagingMode == false) {
              provider.resetFriendSearchData();
            }
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
                // TODO: 친구초대용 링크 복사 기능 삽입하기
                onPressed: () async {},
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
                        child: const Text(
                          '내 친구들',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Visibility(
                        replacement:
                            const Center(child: FriendListPlaceholderWidget()),
                        visible:
                            viewModel.friendFutureUserList?.isNotEmpty ?? false,
                        child: Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              unawaited(
                                ref
                                    .read(friendListViewModelProvider.notifier)
                                    .getAppliedFriendList()
                                    .whenComplete(() => setState(() {})),
                              );
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 64),
                              itemCount: viewModel.friendFutureUserList!.length,
                              itemBuilder: (context, index) {
                                return FriendListCellWidget(
                                  futureUserEntity:
                                      viewModel.friendFutureUserList![index],
                                  cellState: FriendListCellState.normal,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // in managing mode
          // child: Container(),
          child: RefreshIndicator(
            onRefresh: () async {
              unawaited(
                ref
                    .read(friendListViewModelProvider.notifier)
                    .getAppliedFriendList()
                    .whenComplete(() => setState(() {})),
              );
              unawaited(
                ref
                    .read(friendListViewModelProvider.notifier)
                    .getFriendList()
                    .whenComplete(() => setState(() {})),
              );
            },
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: FriendListTextFieldWidget(
                        searchCallback: (searchedHandle) async {
                          if (searchedHandle != null &&
                              searchedHandle.isNotEmpty) {
                            provider
                                .searchUserByHandle(
                                  handle: searchedHandle,
                                )
                                .whenComplete(() => setState(() {}));
                          }
                        },
                      ),
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
                        // ignore: lines_longer_than_80_chars
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
      ),
    );
  }
}
