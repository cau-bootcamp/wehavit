import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class ResolutionListCellWidget extends ConsumerStatefulWidget {
  const ResolutionListCellWidget({
    super.key,
    required this.resolutionEntity,
    required this.showDetails,
  });

  final ResolutionEntity resolutionEntity;
  final bool showDetails;

  @override
  ConsumerState<ResolutionListCellWidget> createState() => _ResolutionListCellWidgetState();
}

class _ResolutionListCellWidgetState extends ConsumerState<ResolutionListCellWidget> {
  @override
  Widget build(BuildContext context) {
    EitherFuture<List<bool>> futureDoneList = ref.watch(getTargetResolutionDoneListForWeekUsecaseProvider)(
      resolutionId: widget.resolutionEntity.resolutionId ?? '',
      startMonday: DateTime.now().getMondayDateTime(),
    );

    final daysSinceFirstDay = DateTime.now().difference(widget.resolutionEntity.startDate ?? DateTime.now()).inDays + 1;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: CustomColors.whSemiBlack,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                ResolutionListCellHeadWidget(
                  goalStatement: widget.resolutionEntity.goalStatement ?? '',
                  resolutionName: widget.resolutionEntity.resolutionName ?? '',
                  showGoalStatement: widget.showDetails,
                  pointColor: PointColors.colorList[widget.resolutionEntity.colorIndex ?? 0],
                  iconIndex: widget.resolutionEntity.iconIndex ?? 0,
                ),
                const SizedBox(
                  height: 12,
                ),
                ResolutionLinearGaugeWidget(
                  resolutionEntity: widget.resolutionEntity,
                  futureDoneList: futureDoneList,
                ),
                SizedBox(
                  height: widget.showDetails ? 20 : 4,
                ),
                Visibility(
                  visible: widget.showDetails,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        daysSinceFirstDay == 1 ? '오늘부터 도전' : '$daysSinceFirstDay일째 도전 중',
                        style: const TextStyle(
                          color: CustomColors.whWhite,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ResolutionListWeeklyDoneWidget(
                        futureDoneList: futureDoneList,
                        pointColor: PointColors.colorList[widget.resolutionEntity.colorIndex ?? 0],
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

class ResolutionListCellHeadWidget extends StatelessWidget {
  const ResolutionListCellHeadWidget({
    super.key,
    required this.resolutionName,
    required this.goalStatement,
    required this.showGoalStatement,
    required this.pointColor,
    required this.iconIndex,
  });

  final String resolutionName;
  final String goalStatement;
  final bool showGoalStatement;
  final Color pointColor;
  final int iconIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: pointColor,
          ),
          child: Image.asset(CustomIconImage.resolutionIcons[iconIndex]),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                resolutionName,
                style: TextStyle(
                  color: pointColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: showGoalStatement,
                child: Text(
                  goalStatement,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Icon(
          Icons.chevron_right,
          size: 32,
          color: pointColor,
        ),
      ],
    );
  }
}

class ResolutionListWeeklyDoneWidget extends StatelessWidget {
  const ResolutionListWeeklyDoneWidget({
    super.key,
    required this.futureDoneList,
    required this.pointColor,
  });

  final EitherFuture<List<bool>> futureDoneList;
  final Color pointColor;

  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<List<bool>>(
      target: futureDoneList,
      forWaiting: Row(
        children: List<Widget>.generate(
          7,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: ResolutionListWeeklyDoneCellPlaceholderWidget(),
          ),
        ),
      ),
      forFail: Row(
        children: List<Widget>.generate(
          7,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: ResolutionListWeeklyDoneCellPlaceholderWidget(),
          ),
        ),
      ),
      mainWidgetCallback: (doneList) {
        return Row(
          children: List<Widget>.generate(
            7,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ResolutionListWeeklyDoneCellWidget(
                isDone: doneList[index],
                weekday: index,
                pointColor: pointColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

///
/// weekday는 월요일부터 0 ~ 일요일 6
class ResolutionListWeeklyDoneCellWidget extends StatelessWidget {
  const ResolutionListWeeklyDoneCellWidget({
    super.key,
    required this.isDone,
    required this.weekday,
    required this.pointColor,
  });

  final int weekday;
  final bool isDone;
  final Color pointColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDone,
      replacement: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.whSemiBlack,
          border: Border.all(
            color: CustomColors.whBrightGrey,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.only(top: 2),
        width: 25,
        height: 25,
        alignment: Alignment.center,
        child: Text(
          weekdayKorean[weekday],
          style: const TextStyle(
            color: CustomColors.whBrightGrey,
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pointColor,
        ),
        alignment: Alignment.center,
        width: 25,
        height: 25,
        child: const Icon(
          Icons.check,
          color: CustomColors.whWhite,
          size: 22,
          weight: 100,
        ),
      ),
    );
  }
}

class ResolutionListWeeklyDoneCellPlaceholderWidget extends StatelessWidget {
  const ResolutionListWeeklyDoneCellPlaceholderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.whSemiBlack,
        border: Border.all(
          color: CustomColors.whBrightGrey,
          width: 2,
        ),
      ),
      width: 25,
      height: 25,
      alignment: Alignment.center,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.whBrightGrey,
        ),
        width: 4,
        height: 4,
      ),
    );
  }
}

class ResolutionLinearGaugeWidget extends StatelessWidget {
  const ResolutionLinearGaugeWidget({
    required this.resolutionEntity,
    required this.futureDoneList,
    super.key,
  });

  final ResolutionEntity? resolutionEntity;
  final EitherFuture<List<bool>> futureDoneList;

  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<List<bool>>(
      target: futureDoneList,
      forWaiting: Column(
        children: [
          Row(
            children: [
              Text(
                resolutionEntity?.actionStatement ?? '',
                style: const TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          LinearProgressIndicator(
            minHeight: 7,
            color: PointColors.colorList[resolutionEntity?.colorIndex ?? 0],
            backgroundColor: CustomColors.whDarkBlack,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ],
      ),
      forFail: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Text(
                '정보를 가져오는데 실패했어요',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 7,
            color: CustomColors.whBrightGrey,
          ),
        ],
      ),
      mainWidgetCallback: (successList) {
        final successCount = successList.where((element) => element == true).length;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    resolutionEntity?.actionStatement ?? '',
                    style: const TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  width: 4.0,
                ),
                Text(
                  // ignore: lines_longer_than_80_chars
                  '주 ${resolutionEntity?.actionPerWeek ?? '-'}회 중 $successCount회 실천',
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 7,
                    width: double.infinity,
                    color: CustomColors.whDarkBlack,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: successCount,
                        child: Container(
                          height: 7,
                          color: PointColors.colorList[resolutionEntity?.colorIndex ?? 0],
                        ),
                      ),
                      Flexible(
                        flex: (resolutionEntity?.actionPerWeek ?? 1) - successCount,
                        child: Container(
                          height: 7,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
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
