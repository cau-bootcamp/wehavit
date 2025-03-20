import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
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
    // 친구 신청 시 debounce 처리
    // 텍스트 입력 후 0.5초간의 debounce 후 검색을 자동으로 수행
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
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(appliedUserUidListProvider);
                    ref.invalidate(friendUidListProvider);
                  },
                  child: ListView(
                    children: [
                      friendList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // in managing mode
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(friendUidListProvider);
              ref.invalidate(appliedUserUidListProvider);
            },
            child: ListView(
              children: [
                friendSearch(),
                friendRequestList(),
                friendList(),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column friendSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '친구 신청',
          style: context.titleSmall,
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
                          onRequest: () async {
                            ref
                                .read(friendListViewModelProvider.notifier)
                                .applyToBeFrendWith(targetUid: uidList[index])
                                .whenComplete(() {
                              // ignore: use_build_context_synchronously
                              showToastMessage(context, text: '성공적으로 친구 요청을 보냈어요');
                            });
                          },
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
    );
  }

  Consumer friendRequestList() {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(appliedUserUidListProvider).when(
          data: (uidList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '새로운 친구 요청',
                  style: context.titleSmall,
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
                          onAccept: () async {
                            ref
                                .read(friendListViewModelProvider.notifier)
                                .acceptToBeFriendWith(targetUid: uidList[index]);
                          },
                          onRefuse: () async {
                            ref
                                .read(friendListViewModelProvider.notifier)
                                .refuseToBeFriendWith(targetUid: uidList[index]);
                          },
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
    );
  }

  Consumer friendList() {
    return Consumer(
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
                  '내 친구들',
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
                        type: isManagingMode ? UserProfileCellType.deleteMode : UserProfileCellType.normal,
                        onDelete: () async {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('정말 친구를 삭제하시겠어요?'),
                                actions: [
                                  CupertinoDialogAction(
                                    textStyle: const TextStyle(
                                      color: CustomColors.pointBlue,
                                    ),
                                    isDefaultAction: true,
                                    child: const Text('취소'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () async {
                                      await ref
                                          .read(friendListViewModelProvider.notifier)
                                          .removeFriend(targetUid: friendUidList[index])
                                          .whenComplete(() {
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                    child: const Text('친구 삭제'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
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
    );
  }
}
