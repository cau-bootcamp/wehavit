import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/presentation/my_page/presentation/widgets/resolution_accomplishment_donut_graph_datamodel.dart';

class ResolutionDoughnutGraphWidget extends StatelessWidget {
  ResolutionDoughnutGraphWidget({
    super.key,
    required List<ConfirmPostEntity> sourceData,
    required int duration,
  }) {
    sourceData.sort((a, b) => a.toString().compareTo(b.toString()));
    data = sourceData.where((element) {
      return todaysDate.difference(element.createdAt!).inDays < duration;
    }).toList();

    ratioOfDoneDays = (data.length / duration) * 100;
  }

  late final List<ConfirmPostEntity> data;
  final todaysDate = DateTime.now();
  late final double ratioOfDoneDays;

  List<DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>>
      _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel,
        String>>[
      DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>(
        dataSource: <ResolutionAccomplishmentDonutGraphDataModel>[
          ResolutionAccomplishmentDonutGraphDataModel(
            x: 'do',
            y: ratioOfDoneDays,
          ),
          ResolutionAccomplishmentDonutGraphDataModel(
            x: 'skip',
            y: 100 - ratioOfDoneDays,
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
      palette: const [
        CustomColors.whYellow,
        CustomColors.whYellowDark,
      ],
      series: _getDefaultDoughnutSeries(),
      margin: EdgeInsets.zero,
    );
  }
}
