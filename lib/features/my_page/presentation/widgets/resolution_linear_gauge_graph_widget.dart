import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';

class ResolutionLinearGaugeGraphWidget extends StatelessWidget {
  const ResolutionLinearGaugeGraphWidget({super.key, required this.data});

  final List<ConfirmPostModel> data;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      showTicks: false,
      showAxisTrack: false,
      showLabels: false,
      maximum: 13,
      markerPointers: List<LinearWidgetPointer>.generate(
        14,
        (int index) => _buildLinearWidgetPointer(
          index.toDouble(),
          index % 4 == 1 ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  LinearWidgetPointer _buildLinearWidgetPointer(double value, Color color) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      child: Container(
        height: 30,
        width: 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
      ),
    );
  }
}
