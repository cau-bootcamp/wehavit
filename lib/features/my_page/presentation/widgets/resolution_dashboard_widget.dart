import 'package:flutter/material.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_doughnut_graph_widget.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_linear_gauge_graph_widget.dart';

class ResolutionDashboardWidget extends StatefulWidget {
  const ResolutionDashboardWidget({Key? key, required this.model})
      : super(key: key);

  final ResolutionModel model;

  @override
  State<ResolutionDashboardWidget> createState() =>
      _ResolutionDashboardWidgetState();
}

class _ResolutionDashboardWidgetState extends State<ResolutionDashboardWidget> {
  late String goalStatement = widget.model.goal;
  late String actionStatement = widget.model.action;

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
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const ResolutionLinearGaugeGraphWidget(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const ResolutionLinearGaugeGraphWidget(),
                    // width: 200,
                    // height: 50,
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
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const ResolutionDoughnutGraphWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
