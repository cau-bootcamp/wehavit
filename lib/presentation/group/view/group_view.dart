import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  @override
  Widget build(BuildContext context) {
    final groupViewModel = ref.watch(groupViewModelProvider);

    // List<Widget>.generate(groupViewModel.myGroupList!.length, (index) => GroupListViewCellWidget(cellModel: groupViewModel.myGroupList![index]))

    List<Widget> groupListViewCellList = [
      GroupListViewCellWidget(
        cellModel: GroupListViewCellWidgetModel.dummyModel,
      ),
      GroupListViewCellWidget(
        cellModel: GroupListViewCellWidgetModel.dummyModel,
      ),
      GroupListViewAddCellWidget(
        tapAddGroupCallback: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return GradientBottomSheet(
                Column(
                  children: [
                    ColoredButton(
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
                    ColoredButton(
                      buttonTitle: '새로운 그룹 만들기',
                      buttonIcon: Icons.flag_outlined,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return CreateGroupView();
                            },
                          ),
                        ).then((_) => Navigator.pop(context));
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ColoredButton(
                      buttonTitle: '돌아가기',
                      onPressed: () {},
                      isDiminished: true,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '참여중인 그룹 목록',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: groupViewModel.myGroupList!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: groupListViewCellList[index],
            );
          },
        ),
      ),
    );
  }
}
