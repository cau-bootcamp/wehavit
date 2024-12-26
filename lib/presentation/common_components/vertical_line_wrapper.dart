import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class VerticalLineWrapper extends StatelessWidget {
  const VerticalLineWrapper({
    required this.contents,
    this.color = CustomColors.pointYellow,
    super.key,
  });

  final Color color;
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 4.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contents,
            ),
          ),
        ],
      ),
    );
  }
}
