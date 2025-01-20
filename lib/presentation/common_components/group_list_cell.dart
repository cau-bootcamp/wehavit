import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/vertical_line_wrapper.dart';
import 'package:wehavit/presentation/state/group_list/group_list_cell_model_provider.dart';

class GroupListCellModel {
  GroupListCellModel({
    required this.groupEntity,
    required this.sharedPostCount,
    required this.sharedResolutionCount,
  });

  GroupEntity groupEntity;
  final int sharedResolutionCount;
  final int sharedPostCount;

  GroupListCellModel copyWith({
    GroupEntity? groupEntity,
    int? sharedPostCount,
    int? sharedResolutionCount,
  }) {
    return GroupListCellModel(
      groupEntity: groupEntity ?? this.groupEntity,
      sharedPostCount: sharedPostCount ?? this.sharedPostCount,
      sharedResolutionCount: sharedResolutionCount ?? this.sharedResolutionCount,
    );
  }

  static final dummyModel = EitherFuture.delayed(
    const Duration(seconds: 2),
    () => right(
      GroupListCellModel(
        groupEntity: GroupEntity(
          groupName: '갱생프로젝트',
          groupManagerUid: 'groupManagerUid',
          groupMemberUidList: [],
          groupColor: 5,
          groupId: '12345',
          groupCreatedAt: DateTime.now().subtract(const Duration(days: 3)),
          groupDescription: '',
          groupRule: '',
        ),
        sharedResolutionCount: 13,
        sharedPostCount: 15,
      ),
    ),
  );
}

class GroupListCell extends StatelessWidget {
  const GroupListCell({
    super.key,
    required this.groupEntity,
  });

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.whGrey300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<GroupListCellModel> cellModel = ref.watch(groupListCellModelProvider(groupEntity));

          return GroupListCellContent(
            asyncCellModel: cellModel,
          );
        },
      ),
    );
  }
}

class GroupListFriendCell extends StatelessWidget {
  const GroupListFriendCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.whGrey300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<GroupListCellModel> cellModel = ref.watch(groupListFriendCellModelProvider);

          return GroupListCellContent(
            asyncCellModel: cellModel,
            isFriendCell: true,
          );
        },
      ),
    );
  }
}

class GroupListCellContent extends StatelessWidget {
  const GroupListCellContent({
    super.key,
    required this.asyncCellModel,
    this.isFriendCell = false,
  });

  final AsyncValue<GroupListCellModel> asyncCellModel;
  final bool isFriendCell;

  @override
  Widget build(BuildContext context) {
    return asyncCellModel.when(
      data: (cellModel) {
        final pointColor =
            isFriendCell ? CustomColors.whYellow500 : CustomColors.pointColorList[cellModel.groupEntity.groupColor];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isFriendCell)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: SizedBox(
                  height: 16.0,
                  child: Text(
                    '함께한 지 ${DateTime.now().difference(cellModel.groupEntity.groupCreatedAt).inDays + 1}일 째',
                    style: context.bodyLarge?.copyWith(
                      color: pointColor,
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 30,
              child: Text(
                isFriendCell ? '내 친구들' : cellModel.groupEntity.groupName,
                style: context.titleLarge?.copyWith(
                  color: pointColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            VerticalLineWrapper(
              color: pointColor,
              contents: [
                SizedBox(
                  height: 22,
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(isFriendCell ? '친구 수' : '멤버 수', style: context.bodyMedium),
                      const SizedBox(width: 8),
                      Text(
                        cellModel.groupEntity.groupMemberUidList.length.toString(),
                        style: context.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 22,
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(isFriendCell ? '나에게 공유중인 목표 수' : '함께 도전중인 목표 수', style: context.bodyMedium),
                      const SizedBox(width: 8),
                      Text(
                        cellModel.sharedResolutionCount.toString(),
                        style: context.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 22,
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('현재까지 올라온 인증글 수', style: context.bodyMedium),
                      const SizedBox(width: 8),
                      Text(
                        cellModel.sharedPostCount.toString(),
                        style: context.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
      error: (_, __) {
        return Container();
      },
      loading: () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 110,
              height: 16,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: CustomColors.whGrey400,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 160,
              height: 30,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: CustomColors.whGrey400,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            VerticalLineWrapper(
              color: CustomColors.whGrey400,
              contents: [
                Container(
                  width: 70,
                  height: 22,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: CustomColors.whGrey400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 22,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: CustomColors.whGrey400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 126,
                  height: 22,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: CustomColors.whGrey400,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
