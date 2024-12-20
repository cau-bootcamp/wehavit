import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

enum WHIconsize {
  large,
  medium,
  small;
}

class WHIcon extends StatelessWidget {
  const WHIcon({
    required this.size,
    required this.iconString,
    this.iconColor = CustomColors.whGrey900,
    super.key,
  });

  final WHIconsize size;
  final String iconString;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final iconSize = switch (size) {
      WHIconsize.large => 28.0,
      WHIconsize.medium => 22.0,
      WHIconsize.small => 16.0,
    };

    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Text(
        iconString,
        style: TextStyle(
          fontFamily: 'SF-Pro',
          color: iconColor,
          fontSize: iconSize,
        ),
      ),
    );
  }
}

class WhIconButton extends StatelessWidget {
  const WhIconButton({
    required this.size,
    required this.iconString,
    this.buttonLabel = '',
    this.badgeCount = 0,
    required this.onPressed,
    super.key,
  });

  final WHIconsize size;
  final String iconString;
  final int badgeCount;
  final String buttonLabel;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = switch (size) {
      WHIconsize.large => context.labelLarge,
      WHIconsize.medium => context.labelLarge,
      WHIconsize.small => context.labelMedium,
    };
    final contentGap = switch (size) {
      WHIconsize.large => 8.0,
      WHIconsize.medium => 6.0,
      WHIconsize.small => 4.0,
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
    final whIcon = Stack(
      children: [
        WHIcon(size: size, iconString: iconString),
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

    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
      onPressed: () {
        onPressed;
      },
      child: buttonLabel.isEmpty
          ? whIcon
          : Row(
              children: [
                whIcon,
                SizedBox(
                  width: contentGap,
                ),
                Text(
                  buttonLabel,
                  style: labelTextStyle,
                ),
              ],
            ),
    );
  }
}
