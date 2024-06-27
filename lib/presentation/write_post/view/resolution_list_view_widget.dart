import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class ResolutionSummaryCardWidget extends StatelessWidget {
  const ResolutionSummaryCardWidget({
    super.key,
    required this.futureDoneRatio,
    required this.futureDoneCount,
  });

  final EitherFuture<int>? futureDoneCount;
  final EitherFuture<int>? futureDoneRatio;

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
                  futureValue: futureDoneCount,
                  unit: '회',
                ),
                const SizedBox(
                  height: 16,
                ),
                ResolutionSummaryCardTextWidget(
                  title: '이번 주 목표 달성 현황',
                  futureValue: futureDoneRatio,
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

class ResolutionSummaryCardTextWidget extends StatefulWidget {
  const ResolutionSummaryCardTextWidget({
    super.key,
    required this.title,
    required this.futureValue,
    required this.unit,
  });

  final String title;
  final EitherFuture<int>? futureValue;
  final String unit;

  @override
  State<ResolutionSummaryCardTextWidget> createState() =>
      _ResolutionSummaryCardTextWidgetState();
}

class _ResolutionSummaryCardTextWidgetState
    extends State<ResolutionSummaryCardTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: CustomColors.whBlack,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
        EitherFutureBuilder<int>(
          target: widget.futureValue,
          forWaiting: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '--',
                style: TextStyle(
                  fontFamily: 'Giants',
                  color: CustomColors.whWhite,
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.unit,
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
          forFail: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '--',
                style: TextStyle(
                  fontFamily: 'Giants',
                  color: CustomColors.whWhite,
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.unit,
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
          mainWidgetCallback: (value) {
            return Row(
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
                  widget.unit,
                  style: const TextStyle(
                    fontFamily: 'Giants',
                    height: 1.8,
                    color: CustomColors.whWhite,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class AddResolutionCellWidget extends StatelessWidget {
  const AddResolutionCellWidget({
    super.key,
    required this.tapAddResolutionCallback,
  });

  final Function tapAddResolutionCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        tapAddResolutionCallback();
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
                  '도전 추가하기',
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
