import 'package:flutter/material.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';

class ResolutionLinearGaugeGraphWidget extends StatelessWidget {
  ResolutionLinearGaugeGraphWidget({
    super.key,
    required List<ConfirmPostModel> sourceData,
    required this.lastPeriod,
  }) {
    sourceData.sort((a, b) => a.toString().compareTo(b.toString()));
    data = sourceData.where((element) {
      if (lastPeriod) {
        return todaysDate.difference(element.createdAt!).inDays < 14 &&
            todaysDate.difference(element.createdAt!).inDays >= 7;
      } else {
        return todaysDate.difference(element.createdAt!).inDays < 7;
      }
    }).toList();
  }

  late final List<ConfirmPostModel> data;
  final bool lastPeriod;
  final todaysDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: List<Widget>.generate(7, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 22,
                transform: Matrix4.skewX(-.5),
                decoration: BoxDecoration(
                  color: data.any(
                    (element) =>
                        todaysDate.difference(element.createdAt!).inDays ==
                        6 - index,
                  )
                      // TODO: 여기에 색깔 넣기
                      ? Colors.amber
                      : Colors.brown,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
