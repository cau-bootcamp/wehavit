import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';
import 'package:wehavit/presentation/my_page/presentation/widgets/resolution_doughnut_graph_widget.dart';
import 'package:wehavit/presentation/my_page/presentation/widgets/resolution_linear_gauge_graph_widget.dart';

class ResolutionDashboardWidget extends ConsumerStatefulWidget {
  const ResolutionDashboardWidget({
    super.key,
    required this.model,
    required this.confirmPostList,
  });

  final ResolutionModel model;
  final Future<List<ConfirmPostModel>> confirmPostList;

  @override
  ConsumerState<ResolutionDashboardWidget> createState() =>
      _ResolutionDashboardWidgetState();
}

class _ResolutionDashboardWidgetState
    extends ConsumerState<ResolutionDashboardWidget> {
  late String goalStatement = widget.model.goalStatement!;
  late String actionStatement = widget.model.actionStatement!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: CustomColors.whSemiBlack,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goalStatement,
                    style: const TextStyle(
                      color: CustomColors.whWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    actionStatement,
                    style: const TextStyle(
                      color: CustomColors.whWhite,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  FutureBuilder<List<ConfirmPostModel>>(
                    future: widget.confirmPostList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              '이번 주 달성률',
                              style: TextStyle(
                                color: CustomColors.whWhite,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: CustomColors.whYellow),
                              child: ResolutionLinearGaugeGraphWidget(
                                sourceData: snapshot.data!,
                                lastPeriod: false,
                              ),
                            ),
                            const Text(
                              '지난 주 달성률',
                              style: TextStyle(
                                color: CustomColors.whWhite,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: CustomColors.whYellowDark),
                              child: ResolutionLinearGaugeGraphWidget(
                                sourceData: snapshot.data!,
                                lastPeriod: true,
                              ),
                              // width: 200,
                              // height: 50,
                            ),
                          ],
                        );
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
          ),
//          Column(
//            children: [
//              const Text(
//                '최근 한 달 달성률',
//                style: TextStyle(
//                  color: CustomColors.whWhite,
//                  fontWeight: FontWeight.normal,
//                  fontSize: 12,
//                ),
//              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: FutureBuilder<List<ConfirmPostModel>>(
                  future: widget.confirmPostList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ResolutionDoughnutGraphWidget(
                        sourceData: snapshot.data!,
                        duration: 14,
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
          ),
        ],
      ),
//        ],
//      ),
    );
  }
}
