import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_doughnut_graph_widget.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_linear_gauge_graph_widget.dart';

class SwipeDashboardWidget extends ConsumerStatefulWidget {
  const SwipeDashboardWidget({
    super.key,
    required this.confirmPostList,
  });

  final Future<List<ConfirmPostModel>> confirmPostList;

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
                  Text(
                    "최근 한 달 달성률",
                    textAlign: TextAlign.start,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: FutureBuilder<List<ConfirmPostModel>>(
                            future: widget.confirmPostList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ResolutionDoughnutGraphWidget(
                                  sourceData: snapshot.data!,
                                );
                              } else if (snapshot.hasError) {
                                return const Placeholder();
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                          // width: 45,
                          // height: 45,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black87),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '90%',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '9/10',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder<List<ConfirmPostModel>>(
                future: widget.confirmPostList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AspectRatio(
                      aspectRatio: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('최근 7일 달성률'),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.black38,
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
                                const Text('지난 7일 달성률'),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.black38,
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
