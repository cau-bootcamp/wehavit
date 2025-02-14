import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

class WeeklyResolutionSummaryCard extends StatelessWidget {
  const WeeklyResolutionSummaryCard({
    super.key,
  });

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
      child: Consumer(
        builder: (context, ref, widget) {
          final asyncSuccessCount = ref.watch(myWeeklyResolutionSummaryProvider);

          final asyncResolutionList = ref.watch(resolutionListNotifierProvider);
          final asyncSuccessRatio = asyncSuccessCount.whenData((successCount) {
            final total = asyncResolutionList.value?.map((e) => e.actionPerWeek).reduce((v, e) => v + e) ?? 0;

            if (total == 0) return 0;

            return ((successCount * 100) / total).ceil();
          });

          return Stack(
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
                      asyncValue: asyncSuccessCount,
                      unit: '회',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ResolutionSummaryCardTextWidget(
                      title: '이번 주 목표 달성 현황',
                      asyncValue: asyncSuccessRatio,
                      unit: '%',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ResolutionSummaryCardTextWidget extends StatefulWidget {
  const ResolutionSummaryCardTextWidget({
    super.key,
    required this.title,
    required this.asyncValue,
    required this.unit,
  });

  final String title;
  final AsyncValue<int> asyncValue;
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
            widget.asyncValue.when(
              data: (data) {
                return Text(
                  data.toString(),
                  style: context.displayLarge?.copyWith(
                    color: CustomColors.whWhite,
                  ),
                );
              },
              error: (_, __) {
                return Text(
                  '--',
                  style: context.displayMedium?.copyWith(
                    color: CustomColors.whWhite,
                  ),
                );
              },
              loading: () {
                return Text(
                  '--',
                  style: context.displayMedium?.copyWith(
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
