import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_doughnut_graph_widget.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_linear_gauge_graph_widget.dart';

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
  late String goalStatement = widget.model.goalStatement;
  late String actionStatement = widget.model.actionStatement;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.green,
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
                  Text(goalStatement),
                  Text(actionStatement),
                  FutureBuilder<List<ConfirmPostModel>>(
                    future: widget.confirmPostList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: ResolutionLinearGaugeGraphWidget(
                                sourceData: snapshot.data!,
                                lastPeriod: false,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
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
          ),
        ],
      ),
    );
  }
}
