import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/presentation/group/group.dart';

class GroupListViewCellWidget extends StatelessWidget {
  const GroupListViewCellWidget({super.key, required this.cellModel});

  final GroupListViewCellWidgetModel cellModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColors.whSemiBlack,
        boxShadow: const [
          BoxShadow(
            color: CustomColors.whBlack,
            blurRadius: 4,
            offset: Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GroupListViewCellContentWidget(
        cellModel: cellModel,
      ),
    );
  }
}

class GroupListViewCellContentWidget extends StatelessWidget {
  const GroupListViewCellContentWidget({super.key, required this.cellModel});

  final GroupListViewCellWidgetModel cellModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // ignore: lines_longer_than_80_chars
          '함께한 지 ${DateTime.now().difference(cellModel.groupEntity.groupCreatedAt).inDays + 1}일 째',
          style: TextStyle(
            color: PointColors.colorList[cellModel.groupEntity.groupColor],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Text(
          cellModel.groupEntity.groupName,
          style: TextStyle(
            color: PointColors.colorList[cellModel.groupEntity.groupColor],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              VerticalDivider(
                thickness: 4,
                width: 16,
                color: PointColors.colorList[cellModel.groupEntity.groupColor],
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GroupListCellBulletWidget(
                      title: '멤버 수',
                      number: cellModel.groupEntity.groupMemberUidList.length,
                    ),
                    const SizedBox(height: 6),
                    GroupListCellBulletFutureWidget(
                      title: '함께 도전중인 목표 수',
                      number: cellModel.sharedResolutionCount,
                    ),
                    const SizedBox(height: 6),
                    GroupListCellBulletFutureWidget(
                      title: '현재까지 올라온 인증글 수',
                      number: cellModel.sharedPostCount,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupListCellBulletWidget extends StatelessWidget {
  const GroupListCellBulletWidget({
    super.key,
    required this.title,
    required this.number,
  });

  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ],
    );
  }
}

class GroupListCellBulletFutureWidget extends StatelessWidget {
  const GroupListCellBulletFutureWidget({
    super.key,
    required this.title,
    required this.number,
  });

  final String title;
  final EitherFuture<int> number;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          FutureBuilder(
            future: number,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!.fold((l) => '0', (r) => r.toString()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                );
              } else {
                // TODO: 나중에 예쁜걸로 수정하기! ******
                return const SizedBox(
                  width: 30,
                  height: 15,
                  child: LinearProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class GroupListViewAddCellWidget extends StatelessWidget {
  const GroupListViewAddCellWidget({
    super.key,
    required this.tapAddGroupCallback,
  });

  final Function tapAddGroupCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        tapAddGroupCallback();
      },
      child: DottedBorder(
        strokeWidth: 2,
        color: CustomColors.whPlaceholderGrey.withAlpha(160),
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [15, 12],
        child: const SizedBox(
          height: 84,
          width: double.infinity,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '그룹 추가하기',
                  style: TextStyle(
                    color: CustomColors.whPlaceholderGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.add_circle_outline,
                  size: 16,
                  color: CustomColors.whPlaceholderGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
