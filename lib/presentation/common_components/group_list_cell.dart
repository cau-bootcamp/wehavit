import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/either_future_builder.dart';
import 'package:wehavit/presentation/group/model/group_list_view_cell_widget_model.dart';

class GroupListCellModel {
  GroupListCellModel({
    required this.groupEntity,
    required this.sharedPostCount,
    required this.sharedResolutionCount,
  });

  GroupEntity groupEntity;
  final int sharedResolutionCount;
  final int sharedPostCount;

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
    required this.cellModel,
  });

  final EitherFuture<GroupListCellModel> cellModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.whGrey300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GroupListCellContent(
        futureCellModel: cellModel,
      ),
    );
  }
}

class GroupListCellContent extends StatelessWidget {
  const GroupListCellContent({
    super.key,
    required this.futureCellModel,
  });

  final EitherFuture<GroupListCellModel> futureCellModel;

  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<GroupListCellModel>(
      target: futureCellModel,
      forWaiting: Column(
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
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    color: CustomColors.whGrey400,
                  ),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                ),
              ],
            ),
          ),
        ],
      ),
      forFail: Container(),
      mainWidgetCallback: (cellModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.0,
              child: Text(
                '함께한 지 ${DateTime.now().difference(cellModel.groupEntity.groupCreatedAt).inDays + 1}일 째',
                style: context.bodyLarge?.copyWith(
                  color: CustomColors.pointColorList[cellModel.groupEntity.groupColor],
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 30,
              child: Text(
                cellModel.groupEntity.groupName,
                style: context.titleLarge?.copyWith(
                  color: CustomColors.pointColorList[cellModel.groupEntity.groupColor],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                      color: CustomColors.pointColorList[cellModel.groupEntity.groupColor],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 22,
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text('멤버 수', style: context.bodyMedium),
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
                              Text('함께 도전중인 목표 수', style: context.bodyMedium),
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
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
