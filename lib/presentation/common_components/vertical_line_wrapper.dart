import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class VerticalLineWrapper extends StatelessWidget {
  const VerticalLineWrapper({
    required this.contents,
    super.key,
  });

  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 4.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              color: CustomColors.whGrey400,
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
