import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';

class ResolutionLinearGaugeGraphWidget extends StatelessWidget {
  ResolutionLinearGaugeGraphWidget({
    super.key,
    required List<ConfirmPostModel> sourceData,
    required this.lastPeriod,
  }) {
    sourceData.sort((a, b) => a.toString().compareTo(b.toString()));
    data = sourceData.where((element) {
      if (lastPeriod) {
        return todaysDate.difference(element.createdAt!).inDays < 28 &&
            todaysDate.difference(element.createdAt!).inDays >= 14;
      } else {
        return todaysDate.difference(element.createdAt!).inDays < 14;
      }
    }).toList();
  }

  late final List<ConfirmPostModel> data;
  final bool lastPeriod;
  final todaysDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      showTicks: false,
      showAxisTrack: false,
      showLabels: false,
      maximum: 13,
      markerPointers: List<LinearWidgetPointer>.generate(
        14,
        (int index) {
          return _buildLinearWidgetPointer(
            index.toDouble(),
            data.any(
              (element) =>
                  todaysDate.difference(element.createdAt!).inDays == index,
            )
                ? Colors.black
                : Colors.white,
          );
        },
      ),
    );
  }

  LinearWidgetPointer _buildLinearWidgetPointer(double value, Color color) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 30),
        width: 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
      ),
    );
  }
}
