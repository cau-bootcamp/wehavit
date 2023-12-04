import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_accomplishment_donut_graph_datamodel.dart';

class ResolutionDoughnutGraphWidget extends StatelessWidget {
  ResolutionDoughnutGraphWidget({
    super.key,
    required List<ConfirmPostModel> sourceData,
  }) {
    sourceData.sort((a, b) => a.toString().compareTo(b.toString()));
    data = sourceData.where((element) {
      return todaysDate.difference(element.createdAt!).inDays < 14;
    }).toList();

    ratioOfDoneDays = (data.length / 14) * 100;
  }

  late final List<ConfirmPostModel> data;
  final todaysDate = DateTime.now();
  late final double ratioOfDoneDays;

  List<DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>>
      _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel,
        String>>[
      DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>(
        dataSource: <ResolutionAccomplishmentDonutGraphDataModel>[
          ResolutionAccomplishmentDonutGraphDataModel(
            x: 'skip',
            y: 100 - ratioOfDoneDays,
          ),
          ResolutionAccomplishmentDonutGraphDataModel(
            x: 'do',
            y: ratioOfDoneDays,
          ),
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
    return SfCircularChart(
      series: _getDefaultDoughnutSeries(),
      margin: EdgeInsets.zero,
    );
  }
}
