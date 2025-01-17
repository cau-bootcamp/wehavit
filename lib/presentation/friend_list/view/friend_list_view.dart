import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class FriendListView extends ConsumerStatefulWidget {
  const FriendListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FrinedListViewState();
}

class FrinedListViewState extends ConsumerState<FriendListView> {
  bool isManagingMode = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(friendListViewModelProvider);
    final provider = ref.read(friendListViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '친구 목록',
        trailingTitle: isManagingMode ? '완료' : '',
        trailingIconString: isManagingMode ? '' : WHIcons.friend,
        trailingIconBadgeCount: isManagingMode ? 0 : viewModel.appliedFutureUserList?.length ?? 0,
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
              const MyProfileBlock(),
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
                      Consumer(
                        builder: (context, ref, child) {
                          final asyncFriendUidList = ref.watch(friendUidListProvider);

                          return asyncFriendUidList.when(
                            data: (friendUidList) {
                              if (friendUidList.isEmpty) {
                                return const Center(child: FriendListPlaceholderWidget());
                              }
                              return Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    unawaited(
                                      ref
                                          .read(friendListViewModelProvider.notifier)
                                          .getFriendList()
                                          .whenComplete(() => setState(() {})),
                                    );
                                  },
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 64),
                                    itemCount: friendUidList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: UserProfileCell(
                                          friendUidList[index],
                                          type: UserProfileCellType.normal,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            error: (_, __) {
                              return Container();
                            },
                            loading: () {
                              return Container();
                            },
                          );
                        },
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
                ref.read(friendListViewModelProvider.notifier).getFriendList().whenComplete(() => setState(() {})),
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
                          if (searchedHandle != null && searchedHandle.isNotEmpty) {
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
                            futureUserEntity: viewModel.searchedFutureUserList![index],
                            cellState: FriendListCellState.toApply,
                          ),
                        ),
                      ),
                  ],
                ),
                if (viewModel.appliedFutureUserList == null || viewModel.appliedFutureUserList!.isEmpty)
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
                            futureUserEntity: viewModel.appliedFutureUserList![index],
                            cellState: FriendListCellState.applied,
                          ),
                        ),
                      ),
                    ],
                  ),
                // if (viewModel.friendFutureUserList == null || viewModel.friendFutureUserList!.isEmpty)
                //   Container()
                // else
                Column(
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
                    Consumer(
                      builder: (context, ref, child) {
                        final asyncFriendList = ref.watch(friendUidListProvider);

                        return asyncFriendList.when(
                          data: (friendUidList) {
                            if (friendUidList.isEmpty) {
                              return const Center(child: FriendListPlaceholderWidget());
                            }
                            return Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  unawaited(
                                    ref
                                        .read(friendListViewModelProvider.notifier)
                                        .getFriendList()
                                        .whenComplete(() => setState(() {})),
                                  );
                                },
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 64),
                                  itemCount: friendUidList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: UserProfileCell(
                                        friendUidList[index],
                                        type: UserProfileCellType.normal,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          error: (_, __) {
                            return Container();
                          },
                          loading: () {
                            return Container();
                          },
                        );
                      },
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
