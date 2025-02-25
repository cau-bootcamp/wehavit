import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class ConfirmCountChart extends StatelessWidget {
  const ConfirmCountChart({required this.resolutionEntity, super.key});

  final ResolutionEntity resolutionEntity;
  static List<String> weekdayString = weekdayKorean;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: CustomColors.whGrey,
      ),
      child: SizedBox(
        height: 200,
        child: SfCartesianChart(
          plotAreaBorderColor: Colors.transparent,
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(color: Colors.transparent),
            majorTickLines: const MajorTickLines(color: Colors.transparent),
            labelStyle: context.labelLarge,
          ),
          primaryYAxis: const NumericAxis(
            isVisible: false,
          ),
          series: <CartesianSeries>[
            // Renders bar chart
            ColumnSeries<ChartData, String>(
              animationDuration: 0,
              dataLabelMapper: (datum, index) => datum.y?.toInt().toString(),
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: context.labelLarge,
              ),
              color: CustomColors.pointColorList[resolutionEntity.colorIndex],
              dataSource: List<ChartData>.generate(
                resolutionEntity.weeklyPostCountList.length,
                (index) => ChartData(
                  weekdayString[index],
                  resolutionEntity.weeklyPostCountList[index].toDouble(),
                ),
              ),
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              width: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
