import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/either_future_builder.dart';

class WeeklyResolutionSummaryCard extends StatelessWidget {
  const WeeklyResolutionSummaryCard({
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
              vertical: 20.0,
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
  State<ResolutionSummaryCardTextWidget> createState() => _ResolutionSummaryCardTextWidgetState();
}

class _ResolutionSummaryCardTextWidgetState extends State<ResolutionSummaryCardTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.headlineMedium?.bold.copyWith(
            color: CustomColors.whGrey100,
            letterSpacing: 0.85,
            height: 1.0,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            EitherFutureBuilder<int>(
              target: widget.futureValue,
              forWaiting: Text(
                '--',
                style: context.displayMedium?.copyWith(
                  color: CustomColors.whWhite,
                ),
              ),
              forFail: Text(
                '--',
                style: context.displayMedium?.copyWith(
                  color: CustomColors.whWhite,
                ),
              ),
              mainWidgetCallback: (value) {
                return Text(
                  value.toString(),
                  style: context.displayLarge?.copyWith(
                    color: CustomColors.whWhite,
                  ),
                );
              },
            ),
            Text(
              widget.unit,
              style: context.displayMedium?.copyWith(
                color: CustomColors.whWhite,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
