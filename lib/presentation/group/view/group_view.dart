import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/group/group.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  List<Widget> groupListViewCellList = [
    GroupListViewCellWidget(
      cellModel: GroupListViewCellWidgetModel.dummyModel,
    ),
    GroupListViewCellWidget(
      cellModel: GroupListViewCellWidgetModel.dummyModel,
    ),
    const GroupListViewAddCellWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whBlack,
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
          itemCount: groupListViewCellList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: groupListViewCellList[index],
            );
          },
        ),
      ),
    );
  }
}
