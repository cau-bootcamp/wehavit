import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wehavit/common/constants/constants.dart';

enum WHIconsize {
  large,
  medium,
  small;
}

class WHIcon extends StatelessWidget {
  const WHIcon({
    required this.size,
    required this.iconData,
    this.badgeCount = 0,
    super.key,
  });

  final WHIconsize size;
  final IconData iconData;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final iconSize = switch (size) {
      WHIconsize.large => 28.0,
      WHIconsize.medium => 22.0,
      WHIconsize.small => 16.0,
    };
    final badgeTextStyle = switch (size) {
      WHIconsize.large => context.labelMedium?.bold,
      WHIconsize.medium => context.labelSmall?.bold,
      WHIconsize.small => context.labelSmall?.copyWith(fontSize: 9.0).bold,
    };
    final badgePadding = switch (size) {
      WHIconsize.large => 4.0,
      WHIconsize.medium => 3.0,
      WHIconsize.small => 2.0,
    };

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          iconData,
          size: iconSize,
          color: CustomColors.whGrey900,
        ),
        if (badgeCount > 0)
          Positioned(
            right: -1.5 * badgePadding,
            top: -1.5 * badgePadding,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(badgePadding),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: CustomColors.whRed500),
              child: Text(
                badgeCount.toString(),
                style: badgeTextStyle,
              ),
            ),
          ),
      ],
    );
  }
}
