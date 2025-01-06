import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/wh_icon.dart';

class ColorSelectionListCell extends StatelessWidget {
  const ColorSelectionListCell({
    required this.backgroundColor,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: isSelected
            ? const WHIcon(
                size: WHIconsize.medium,
                iconString: WHIcons.checkMark,
                iconWeight: FontWeight.w600,
              )
            : Container(),
      ),
    );
  }
}
