import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/get_target_resolution_done_list_for_week_usecase.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class ResolutionListCell extends ConsumerStatefulWidget {
  const ResolutionListCell({
    super.key,
    required this.resolutionEntity,
    required this.showDetails,
    required this.onPressed,
  });

  final ResolutionEntity resolutionEntity;
  final bool showDetails;
  final VoidCallback onPressed;

  @override
  ConsumerState<ResolutionListCell> createState() => _ResolutionListCellWidgetState();
}

class _ResolutionListCellWidgetState extends ConsumerState<ResolutionListCell> {
  @override
  Widget build(BuildContext context) {
    // EitherFuture<List<bool>> futureDoneList = ref.watch(getTargetResolutionDoneListForWeekUsecaseProvider)(
    //   param: GetTargetResolutionDoneListForWeekUsecaseParams(
    //     resolutionId: widget.resolutionEntity.resolutionId,
    //     startMonday: DateTime.now().getMondayDateTime(),
    //   ),
    // );

    final daysSinceFirstDay = DateTime.now().difference(widget.resolutionEntity.startDate).inDays + 1;

    return TextButton(
      style: TextButton.styleFrom(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: CustomColors.whGrey300,
        overlayColor: CustomColors.pointColorList[widget.resolutionEntity.colorIndex],
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onPressed: widget.onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          children: [
            ResolutionListCellHeadWidget(
              goalStatement: widget.resolutionEntity.goalStatement,
              resolutionName: widget.resolutionEntity.resolutionName,
              pointColor: CustomColors.pointColorList[widget.resolutionEntity.colorIndex],
              iconIndex: widget.resolutionEntity.iconIndex,
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, _) {
                return ResolutionLinearGaugeIndicator(
                  resolutionEntity: widget.resolutionEntity,
                  futureDoneList: ref.watch(getTargetResolutionDoneListForWeekUsecaseProvider)(
                    param: GetTargetResolutionDoneListForWeekUsecaseParams(
                      resolutionId: widget.resolutionEntity.resolutionId,
                      startMonday: DateTime.now().getMondayDateTime(),
                    ),
                  ),
                );
              },
            ),
            if (widget.showDetails)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        daysSinceFirstDay == 1 ? '오늘부터 도전' : '$daysSinceFirstDay일째 도전 중',
                        style: context.bodyMedium?.copyWith(
                          color: CustomColors.whGrey700,
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, _) {
                          return ResolutionListWeeklyDoneWidget(
                            futureDoneList: ref.watch(getTargetResolutionDoneListForWeekUsecaseProvider)(
                              param: GetTargetResolutionDoneListForWeekUsecaseParams(
                                resolutionId: widget.resolutionEntity.resolutionId,
                                startMonday: DateTime.now().getMondayDateTime(),
                              ),
                            ),
                            pointColor: CustomColors.pointColorList[widget.resolutionEntity.colorIndex],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ResolutionListCellHeadWidget extends StatelessWidget {
  const ResolutionListCellHeadWidget({
    super.key,
    required this.resolutionName,
    required this.goalStatement,
    required this.pointColor,
    required this.iconIndex,
  });

  final String resolutionName;
  final String goalStatement;
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
                style: context.titleSmall?.copyWith(
                  color: pointColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                goalStatement,
                style: context.bodyMedium?.copyWith(
                  color: CustomColors.whGrey900,
                  height: 1.2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        WHIcon(
          iconString: WHIcons.forward,
          size: WHIconsize.small,
          iconColor: pointColor,
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
    final indicatorPlaceholder = Row(
      children: List<Widget>.generate(
        7,
        (index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: CircularStatusIndicator(isDone: false),
        ),
      ),
    );

    return EitherFutureBuilder<List<bool>>(
      target: futureDoneList,
      forWaiting: indicatorPlaceholder,
      forFail: indicatorPlaceholder,
      mainWidgetCallback: (doneList) {
        return Row(
          children: List<Widget>.generate(
            7,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: CircularStatusIndicator(
                isDone: doneList[index],
                pointColor: pointColor,
                innerLabel: weekdayKorean[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
