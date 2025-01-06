import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class CountAndDescription extends StatelessWidget {
  const CountAndDescription({
    required this.count,
    required this.unit,
    required this.description,
    super.key,
  });

  final int count;
  final String unit;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: CustomColors.whGrey300, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: context.headlineSmall?.copyWith(color: CustomColors.whGrey900),
                children: [
                  TextSpan(text: count.toString()),
                  TextSpan(text: unit),
                ],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              description,
              style: context.bodyMedium?.copyWith(color: CustomColors.whGrey600, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
