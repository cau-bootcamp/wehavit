import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/debouncer.dart';

enum WHIconsize {
  large,
  medium,
  small,
  extraSmall;
}

class WHIcon extends StatelessWidget {
  const WHIcon({
    required this.size,
    required this.iconString,
    this.iconColor = CustomColors.whGrey900,
    this.iconWeight = FontWeight.w500,
    super.key,
  });

  final WHIconsize size;
  final String iconString;
  final Color iconColor;
  final FontWeight iconWeight;

  @override
  Widget build(BuildContext context) {
    final iconSize = switch (size) {
      WHIconsize.large => 28.0,
      WHIconsize.medium => 22.0,
      WHIconsize.small => 16.0,
      WHIconsize.extraSmall => 13.0,
    };

    return SizedBox(
      // width: iconSize,
      // height: iconSize,
      child: Text(
        iconString,
        style: TextStyle(
          fontFamily: 'SF-Pro',
          color: iconColor,
          fontWeight: iconWeight,
          fontSize: iconSize,
        ),
      ),
    );
  }
}

class WhIconButton extends StatefulWidget {
  const WhIconButton({
    required this.size,
    required this.iconString,
    this.buttonLabel = '',
    this.badgeCount = 0,
    required this.onPressed,
    this.color = CustomColors.whGrey900,
    super.key,
  });

  final WHIconsize size;
  final String iconString;
  final int badgeCount;
  final String buttonLabel;
  final Function onPressed;
  final Color color;

  @override
  State<WhIconButton> createState() => _WhIconButtonState();
}

class _WhIconButtonState extends State<WhIconButton> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 100));

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = switch (widget.size) {
      WHIconsize.large => context.labelLarge?.copyWith(color: widget.color),
      WHIconsize.medium => context.labelLarge?.copyWith(color: widget.color),
      WHIconsize.small => context.labelMedium?.copyWith(color: widget.color),
      WHIconsize.extraSmall => context.labelSmall?.copyWith(color: widget.color),
    };
    final contentGap = switch (widget.size) {
      WHIconsize.large => 16.0,
      WHIconsize.medium => 14.0,
      WHIconsize.small => 10.0,
      WHIconsize.extraSmall => 8.0,
    };
    final badgeTextStyle = switch (widget.size) {
      WHIconsize.large => context.labelMedium?.bold,
      WHIconsize.medium => context.labelSmall?.bold,
      WHIconsize.small => context.labelSmall?.copyWith(fontSize: 9.0).bold,
      WHIconsize.extraSmall => context.labelSmall,
    };
    final badgePadding = switch (widget.size) {
      WHIconsize.large => 4.0,
      WHIconsize.medium => 3.0,
      WHIconsize.small => 2.0,
      WHIconsize.extraSmall => 2.0,
    };
    final whIcon = Stack(
      clipBehavior: Clip.none,
      children: [
        WHIcon(
          size: widget.size,
          iconString: widget.iconString,
          iconColor: widget.color,
        ),
        if (widget.badgeCount > 0)
          Positioned(
            right: -1.5 * badgePadding,
            top: -1.5 * badgePadding,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(badgePadding),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: CustomColors.whRed500),
              child: Text(
                widget.badgeCount.toString(),
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
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        _debouncer.run(() {
          widget.onPressed();
        });
      },
      child: switch ((widget.buttonLabel.isNotEmpty, widget.iconString.isNotEmpty)) {
        (true, true) => Row(
            children: [
              whIcon,
              SizedBox(width: contentGap),
              Text(widget.buttonLabel, style: labelTextStyle),
            ],
          ),
        (false, true) => whIcon,
        (true, false) => Text(
            widget.buttonLabel,
            style: labelTextStyle,
            textAlign: TextAlign.left,
          ),
        (false, false) => throw UnimplementedError(),
      },
    );
  }
}
