import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
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
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: const WehavitAppBar(
        titleLabel: '참여중인 그룹 목록',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(groupListFriendCellModelProvider);
            ref.invalidate(groupListCellModelProvider);
          },
          child: Consumer(
            builder: (context, ref, child) {
              final asyncGroupList = ref.watch(groupListProvider);

              return asyncGroupList.when(
                data: (groupList) {
                  List<Widget> groupListViewCellList = [
                    GroupListFriendCell(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const FriendPostView();
                            },
                          ),
                        ).whenComplete(
                          () => ref.invalidate(groupListFriendCellModelProvider),
                        );
                      },
                    ),
                    ...groupList.map(
                      (entity) => GroupListCell(
                        groupEntity: entity,
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GroupPostView(groupEntity: entity);
                              },
                            ),
                          ).whenComplete(() => ref.invalidate(groupListCellModelProvider(entity)));
                        },
                      ),
                    ),
                    ListDashOutlinedCell(
                      buttonLabel: '그룹 추가하기',
                      onPressed: () async {
                        showAddMenuBottomSheet(
                          context,
                        ).whenComplete(() {
                          ref.invalidate(groupListProvider);
                        });
                      },
                    ),
                  ];

                  return ListView.builder(
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
      ),
    );
  }

  Future<dynamic> showAddMenuBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideOutlinedButton(
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
                  ).then((_) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
                // isDiminished: true,
              ),
              const SizedBox(
                height: 12,
              ),
              WideOutlinedButton(
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
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
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
}
