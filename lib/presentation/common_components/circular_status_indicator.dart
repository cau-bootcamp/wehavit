import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/presentation.dart';

class CircularStatusIndicator extends StatelessWidget {
  const CircularStatusIndicator({
    required this.isDone,
    this.innerLabel = '',
    this.pointColor = CustomColors.pointYellow,
    super.key,
  });

  final bool isDone;
  final String innerLabel;
  final Color pointColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? pointColor : Colors.transparent,
        border: Border.all(
          color: CustomColors.whBrightGrey,
          width: isDone ? 0 : 1,
        ),
      ),
      width: 20,
      height: 20,
      alignment: Alignment.center,
      child: isDone
          ? WHIcon(
              size: WHIconsize.extraSmall,
              iconString: WHIcons.checkMark,
              iconColor: isDone ? CustomColors.whGrey900 : CustomColors.whGrey600,
            )
          : Text(
              innerLabel,
              style: context.labelMedium?.copyWith(
                color: isDone ? CustomColors.whGrey900 : CustomColors.whGrey600,
                fontWeight: FontWeight.w400,
                height: 0.8,
              ),
            ),
    );
  }
}
