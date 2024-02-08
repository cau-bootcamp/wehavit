import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/group/viewmodel/viewmodel.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
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
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: GroupListViewCellWidget(
                cellModel: GroupListViewCellWidgetModel.dummyModel,
              ),
            );
          },
        ),
      ),
    );
  }
}

class GroupListViewCellWidget extends StatelessWidget {
  const GroupListViewCellWidget({super.key, required this.cellModel});

  final GroupListViewCellWidgetModel cellModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColors.whGrey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // ignore: lines_longer_than_80_chars
            '함께한 지 ${DateTime.now().difference(cellModel.groupEntity.groupCreatedAt).inDays + 1}일 째',
            style: TextStyle(
              color: PointColors.colorList[cellModel.groupEntity.groupColor],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            cellModel.groupEntity.groupName,
            style: TextStyle(
              color: PointColors.colorList[cellModel.groupEntity.groupColor],
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 2,
                  width: 16,
                  color:
                      PointColors.colorList[cellModel.groupEntity.groupColor],
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GroupListCellBulletWidget(
                        title: '멤버 수',
                        number: cellModel.groupEntity.groupMemberUidList.length,
                      ),
                      const SizedBox(height: 8),
                      GroupListCellBulletFutureWidget(
                        title: '함께 도전중인 목표 수',
                        number: cellModel.sharedResolutionCount,
                      ),
                      const SizedBox(height: 8),
                      GroupListCellBulletFutureWidget(
                        title: '현재까지 올라운 인증글 수',
                        number: cellModel.sharedPostCount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16, height: 1),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            height: 1,
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
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16, height: 1),
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
                  fontSize: 28,
                  height: 1,
                ),
              );
            } else {
              // TODO: 나중에 예쁜걸로 수정하기! ******
              return const SizedBox(
                width: 30,
                height: 30,
                child: LinearProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
