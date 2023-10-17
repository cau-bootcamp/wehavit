import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_accomplishment_donut_graph_datamodel.dart';

class ResolutionDoughnutGraphWidget extends StatelessWidget {
  const ResolutionDoughnutGraphWidget({super.key});

  List<DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>>
      _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel,
        String>>[
      DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>(
        dataSource: <ResolutionAccomplishmentDonutGraphDataModel>[
          ResolutionAccomplishmentDonutGraphDataModel(x: 'do', y: 90),
          ResolutionAccomplishmentDonutGraphDataModel(x: 'skip', y: 10),
        ],
        xValueMapper:
            (ResolutionAccomplishmentDonutGraphDataModel datum, int index) =>
                datum.x,
        yValueMapper:
            (ResolutionAccomplishmentDonutGraphDataModel datum, int index) =>
                datum.y,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(series: _getDefaultDoughnutSeries());
  }
}
