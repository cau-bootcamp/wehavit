import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/presentation/my_page/widgets/resolution_doughnut_graph_widget.dart';
import 'package:wehavit/presentation/my_page/widgets/resolution_linear_gauge_graph_widget.dart';

class SwipeDashboardWidget extends ConsumerStatefulWidget {
  const SwipeDashboardWidget({
    super.key,
    required this.confirmPostList,
  });

  final Future<List<ConfirmPostEntity>> confirmPostList;

  @override
  ConsumerState<SwipeDashboardWidget> createState() =>
      _ResolutionDashboardWidgetState();
}

class _ResolutionDashboardWidgetState
    extends ConsumerState<SwipeDashboardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      clipBehavior: Clip.hardEdge,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    '최근 한 달 달성률',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  FutureBuilder<List<ConfirmPostEntity>>(
                    future: widget.confirmPostList,
                    builder: (context, snapshot) {
                      int durationDays = 28;

                      if (snapshot.hasData) {
                        final sourceData = snapshot.data!;
                        sourceData.sort(
                          (a, b) => a.toString().compareTo(b.toString()),
                        );
                        final data = sourceData.where((element) {
                          return DateTime.now()
                                  .difference(element.createdAt!)
                                  .inDays <
                              durationDays;
                        }).toList();

                        final attendList =
                            List<bool>.generate(durationDays, (index) => false);

                        for (var element in data) {
                          attendList[DateTime.now()
                              .difference(element.createdAt!)
                              .inDays] = true;
                        }

                        int attendedDays = 0;
                        for (bool element in attendList) {
                          attendedDays += element ? 1 : 0;
                        }

                        return Stack(alignment: Alignment.center, children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: CustomColors.whSemiBlack,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20,
                                ),
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ResolutionDoughnutGraphWidget(
                                sourceData: snapshot.data!,
                                duration: durationDays,
                              ),
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 2,
                            child: Container(
                              // width: 45,
                              // height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomColors.whDarkBlack,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${(attendedDays / durationDays * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w800,
                                  color: CustomColors.whWhite,
                                ),
                              ),
                              Text(
                                '$attendedDays/$durationDays',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.whWhite,
                                ),
                              )
                            ],
                          ),
                        ]);
                      } else if (snapshot.hasError) {
                        return const Placeholder();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder<List<ConfirmPostEntity>>(
                future: widget.confirmPostList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AspectRatio(
                      aspectRatio: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '최근 7일 달성률',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.whWhite,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: CustomColors.whBlack,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  child: ResolutionLinearGaugeGraphWidget(
                                    sourceData: snapshot.data!,
                                    lastPeriod: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '지난 7일 달성률',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.whWhite,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: CustomColors.whBlack,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  child: ResolutionLinearGaugeGraphWidget(
                                    sourceData: snapshot.data!,
                                    lastPeriod: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Placeholder();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
