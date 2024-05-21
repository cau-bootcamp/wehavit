import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  @override
  void initState() {
    super.initState();

    unawaited(loadGroupCellList());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupViewModelProvider);
    // final provider = ref.read(groupViewModelProvider.notifier);

    List<Widget> groupListViewCellList = (viewModel.groupListViewCellModelList
                ?.map(
                  (cellModel) => GestureDetector(
                    onTapUp: (details) async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupPostView(
                              groupEntity: cellModel.groupEntity,
                            );
                          },
                        ),
                      ).whenComplete(
                        () => setState(
                          () {},
                        ),
                      );
                    },
                    child: GroupListViewCellWidget(cellModel: cellModel),
                  ),
                )
                .toList() ??
            List<Widget>.empty())
        .append(
      GroupListViewAddCellWidget(
        tapAddGroupCallback: () async {
          showAddMenuBottomSheet(context);
        },
      ),
    ).toList();

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '참여중인 그룹 목록',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: viewModel.groupListViewCellModelList != null,
          replacement: const Center(
            child: Text('something went wrong'),
          ),
          child: Visibility(
            visible: viewModel.groupListViewCellModelList != null,
            child: viewModel.groupListViewCellModelList != null
                ? ListView.builder(
                    itemCount: viewModel.groupListViewCellModelList!.length + 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: groupListViewCellList[index],
                      );
                    },
                  )
                : Container(), // 빈 컨테이너 반환
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
              WideColoredButton(
                buttonTitle: '기존 그룹에 참여하기',
                buttonIcon: Icons.search,
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
                buttonIcon: Icons.flag_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return const CreateGroupView();
                      },
                    ),
                  ).then((_) => Navigator.pop(context));
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '돌아가기',
                onPressed: () {},
                isDiminished: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> loadGroupCellList() async {
    ref
        .read(groupViewModelProvider.notifier)
        .loadMyGroupCellList()
        .whenComplete(() => setState(() {}));
  }
}
