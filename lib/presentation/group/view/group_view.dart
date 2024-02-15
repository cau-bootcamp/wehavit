import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/common_components/gradient_bottom_sheet.dart';
import 'package:wehavit/presentation/group/group.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      height: 12,
                    ),
                    ColoredButton(
                      buttonTitle: 'hi',
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.amber,
                      onPressed: () {},
                      // isDiminished: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ColoredButton(
                      buttonTitle: 'hello there',
                      foregroundColor: Colors.white,
                      onPressed: () {},
                    ),
                    SizedBox(
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
      ),
    );
  }
}
