import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/debouncer.dart';
import 'package:wehavit/presentation/common_components/wh_icon.dart';

class WideOutlinedButton extends StatefulWidget {
  const WideOutlinedButton({
    super.key,
    this.foregroundColor = CustomColors.whGrey800,
    required this.buttonTitle,
    required this.onPressed,
    this.iconString = '',
    this.isDiminished = false,
  });

  final Color foregroundColor;
  final String buttonTitle;
  final String iconString;
  final Function onPressed;
  final bool isDiminished;

  @override
  State<WideOutlinedButton> createState() => _WideOutlinedButtonState();
}

class _WideOutlinedButtonState extends State<WideOutlinedButton> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 100));

  @override
  Widget build(BuildContext context) {
    if (widget.isDiminished) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          side: const BorderSide(
            color: CustomColors.whGrey500,
            width: 2,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: Text(
            widget.buttonTitle,
            style: context.bodyLarge?.bold.copyWith(
              color: CustomColors.whGrey500,
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          _debouncer.run(() {
            widget.onPressed();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: widget.foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          side: BorderSide(
            color: widget.foregroundColor,
            width: 2,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: widget.iconString.isEmpty
              ? Text(
                  widget.buttonTitle,
                  style: context.bodyLarge?.bold.copyWith(color: widget.foregroundColor),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.buttonTitle,
                      style: context.bodyLarge?.bold.copyWith(color: widget.foregroundColor),
                    ),
                    const SizedBox(width: 8),
                    WHIcon(
                      size: WHIconsize.medium,
                      iconString: widget.iconString,
                      iconColor: widget.foregroundColor,
                    ),
                  ],
                ),
        ),
      );
    }
  }
}
