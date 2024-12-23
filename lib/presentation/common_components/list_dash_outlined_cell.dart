import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class ListDashOutlinedCell extends StatelessWidget {
  const ListDashOutlinedCell({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String buttonLabel;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        onPressed();
      },
      child: DottedBorder(
        strokeWidth: 2,
        color: CustomColors.whGrey500,
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        dashPattern: const [12, 12],
        child: SizedBox(
          height: 80,
          width: double.infinity,
          child: Center(
            child: Text(
              buttonLabel,
              style: context.labelLarge?.bold.copyWith(
                color: CustomColors.whGrey500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
