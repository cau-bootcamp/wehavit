import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';
import 'package:wehavit/presentation/state/friend/friend_manage_list_provider.dart';

class FriendListView extends ConsumerStatefulWidget {
  const FriendListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FrinedListViewState();
}

class FrinedListViewState extends ConsumerState<FriendListView> {
  bool isManagingMode = false;

  final searchInputController = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    searchInputController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {});
      });
    });

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '친구 목록',
        trailingTitle: isManagingMode ? '완료' : '',
        trailingIconString: isManagingMode ? '' : WHIcons.friend,
        trailingIconBadgeCount: isManagingMode ? 0 : ref.watch(appliedUserUidListProvider).value?.length ?? 0,
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
              const MyProfileBlock(),
              const SizedBox(height: 32.0),
              // if (viewModel.friendFutureUserList == null)
              //   const FriendListFailPlaceholderWidget()
              // else
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
              ref.invalidate(appliedUserUidListProvider);
              ref.invalidate(friendListProvider);
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
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: SearchFormField(
                        textEditingController: searchInputController,
                        placeholder: 'ID를 검색해보세요',
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        if (searchInputController.text.isEmpty) {
                          return SizedBox(
                            width: double.infinity,
                            child: Text(
                              '친구와 함께 도전하고 격려를 나눠보세요',
                              textAlign: TextAlign.center,
                              style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                            ),
                          );
                        }

                        return ref.watch(searchedUserUidListProvider(searchInputController.text)).when(
                          data: (uidList) {
                            if (uidList.isEmpty) {
                              return SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '해당 ID를 가진 사용자가 없어요',
                                  textAlign: TextAlign.center,
                                  style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                                ),
                              );
                            } else {
                              return Column(
                                children: List<Widget>.generate(
                                  uidList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: UserProfileCell(
                                      uidList[index],
                                      type: UserProfileCellType.inviting,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          error: (_, __) {
                            return SizedBox(
                              width: double.infinity,
                              child: Text(
                                '잠시 후 다시 시도해주세요',
                                textAlign: TextAlign.center,
                                style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                              ),
                            );
                          },
                          loading: () {
                            return Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: LoadingAnimationWidget.waveDots(
                                color: CustomColors.whGrey700,
                                size: 30,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(appliedUserUidListProvider).when(
                      data: (uidList) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '새로운 친구 요청 (${uidList.length})',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whWhite,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            if (uidList.isEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '새로운 친구 요청이 아직 없어요',
                                  textAlign: TextAlign.center,
                                  style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                                ),
                              ),
                            if (uidList.isNotEmpty)
                              Column(
                                children: List<Widget>.generate(
                                  uidList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: UserProfileCell(
                                      uidList[index],
                                      type: UserProfileCellType.invited,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 32,
                            ),
                          ],
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
                Consumer(
                  builder: (context, ref, child) {
                    final asyncFriendUidList = ref.watch(friendUidListProvider);

                    return asyncFriendUidList.when(
                      data: (friendUidList) {
                        if (friendUidList.isEmpty) {
                          return const Center(child: FriendListPlaceholderWidget());
                        }
                        return Column(
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
                            ...List.generate(
                              friendUidList.length,
                              (index) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: UserProfileCell(
                                    friendUidList[index],
                                    type: UserProfileCellType.deleteMode,
                                  ),
                                );
                              },
                            ),
                          ],
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
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
