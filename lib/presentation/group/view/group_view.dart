import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';
import 'package:wehavit/presentation/state/group_list/group_list_cell_model_provider.dart';
import 'package:wehavit/presentation/state/group_list/group_list_provider.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupViewModelProvider);
    final provider = ref.read(groupViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: const WehavitAppBar(
        titleLabel: '참여중인 그룹 목록',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final asyncGroupList = ref.watch(groupListProvider);

            return asyncGroupList.when(
              data: (groupList) {
                List<Widget> groupListViewCellList = [
                  GestureDetector(
                    onTapUp: (details) async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FriendPostView(
                              cellModel: viewModel.groupListViewFriendCellModel!,
                            );
                          },
                        ),
                      ).whenComplete(
                        () => setState(
                          () {},
                        ),
                      );
                    },
                    child: const GroupListFriendCell(),
                  ),
                  ...groupList.map(
                    (entity) => GestureDetector(
                      onTapUp: (details) async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return GroupPostView(
                                groupEntity: entity,
                              );
                            },
                          ),
                        ).whenComplete(
                          () => setState(
                            () {},
                          ),
                        );
                      },
                      child: GroupListCell(groupEntity: entity),
                    ),
                  ),
                  ListDashOutlinedCell(
                    buttonLabel: '그룹 추가하기',
                    onPressed: () async {
                      showAddMenuBottomSheet(
                        context,
                        setStateCallback: () async {
                          await provider.loadMyGroupCellList();
                          setState(() {});
                        },
                      );
                    },
                  ),
                ];

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(groupListFriendCellModelProvider);
                    ref.invalidate(groupListCellModelProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    itemCount: groupListViewCellList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: groupListViewCellList[index],
                      );
                    },
                  ),
                );
              },
              error: (_, __) {
                return const Center(
                  child: Text('something went wrong'),
                );
              },
              loading: () {
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> showAddMenuBottomSheet(
    BuildContext context, {
    required void Function() setStateCallback,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideColoredButton(
                buttonTitle: '기존 그룹에 참여하기',
                iconString: WHIcons.search,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return const JoinGroupView();
                      },
                    ),
                  ).then((_) => Navigator.pop(context));
                },
                // isDiminished: true,
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '새로운 그룹 만들기',
                iconString: WHIcons.group,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return const CreateGroupView();
                      },
                    ),
                  ).then((_) {
                    setStateCallback();
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '돌아가기',
                backgroundColor: Colors.transparent,
                foregroundColor: CustomColors.whPlaceholderGrey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> loadGroupCellList() async {
    ref.read(groupViewModelProvider.notifier).loadMyGroupCellList().whenComplete(() => setState(() {}));
  }

  Future<void> loadFriendCellList() async {
    // TODO: FriendCellList 로직을 State로 분리
    // // final userIdList = await Future.wait(
    // //   ref.read(friendListViewModelProvider).friendFutureUserList?.map((futureFriendEntity) async {
    // //         final result = await futureFriendEntity;
    // //         return result.fold(
    // //           (failure) => null,
    // //           (entity) => entity.userId,
    // //         );
    // //       }).toList() ??
    // //       [],
    // // );

    // final userIdListWithoutNull = userIdList.where((userId) => userId != null).cast<String>().toList();

    // ref.watch(groupViewModelProvider).friendUidList = userIdListWithoutNull;

    // await ref
    //     .read(groupViewModelProvider.notifier)
    //     .loadFriendCellWidgetModel(friendUidList: userIdListWithoutNull)
    //     .whenComplete(() => setState(() {}));
  }
}
