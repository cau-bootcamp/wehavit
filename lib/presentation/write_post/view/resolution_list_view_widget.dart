import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionSummaryCardWidget extends StatelessWidget {
  const ResolutionSummaryCardWidget({
    super.key,
    required this.totalCount,
    required this.doneRatio,
  });

  final int totalCount;
  final double doneRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: CustomColors.whYellow,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                ResolutionSummaryCardTextWidget(
                  title: '이번 주 나의 노력 인증 횟수',
                  value: totalCount,
                  unit: '회',
                ),
                const SizedBox(
                  height: 16,
                ),
                ResolutionSummaryCardTextWidget(
                  title: '이번 주 목표 달성 현황',
                  value: (doneRatio * 100).round(),
                  unit: '%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResolutionSummaryCardTextWidget extends StatelessWidget {
  const ResolutionSummaryCardTextWidget({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });

  final String title;
  final int value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: CustomColors.whBlack,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                fontFamily: 'Giants',
                color: CustomColors.whWhite,
                fontSize: 45,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              unit,
              style: const TextStyle(
                fontFamily: 'Giants',
                height: 1.8,
                color: CustomColors.whWhite,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ResolutionListCellWidget extends StatelessWidget {
  ResolutionListCellWidget(this.model, {super.key});

  final ResolutionListCellWidgetModel model;
  late EitherFuture<int> futureDoneCount;

  @override
  Widget build(BuildContext context) {
    futureDoneCount = Future.delayed(Duration(seconds: 2), () {
      // return left(Failure("he"));
      return right(3);
    });
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: CustomColors.whSemiBlack,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: PointColors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        model.entity.goalStatement ?? '',
                        style: const TextStyle(
                          color: PointColors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 32,
                      color: PointColors.red,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ResolutionLinearGaugeWidget(
                  resolutionEntity: model.entity,
                  futureDoneCount: futureDoneCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResolutionLinearGaugeWidget extends ConsumerStatefulWidget {
  const ResolutionLinearGaugeWidget({
    required this.resolutionEntity,
    required this.futureDoneCount,
    super.key,
  });

  final ResolutionEntity resolutionEntity;
  final EitherFuture<int> futureDoneCount;

  @override
  ConsumerState<ResolutionLinearGaugeWidget> createState() =>
      _ResolutionLinearGaugeWidgetState();
}

class _ResolutionLinearGaugeWidgetState
    extends ConsumerState<ResolutionLinearGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<int>(
      target: widget.futureDoneCount,
      forWaiting: Column(
        children: [
          Row(
            children: [
              Text(
                widget.resolutionEntity.actionStatement ?? '',
                style: const TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          LinearProgressIndicator(
            minHeight: 7,
            color: PointColors.colorList[0],
            backgroundColor: CustomColors.whDarkBlack,
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
      mainWidgetCallback: (successCount) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.resolutionEntity.actionStatement ?? '',
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '주 ${widget.resolutionEntity.actionPerWeek}회 중 $successCount회 실천',
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
            Stack(
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
                        color: PointColors.colorList[0],
                      ),
                    ),
                    Flexible(
                      flex: (widget.resolutionEntity.actionPerWeek ?? 1) -
                          successCount,
                      child: Container(
                        height: 7,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
