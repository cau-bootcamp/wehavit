import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/debouncer.dart';
import 'package:wehavit/presentation/common_components/wh_icon.dart';

class WideColoredButton extends StatefulWidget {
  const WideColoredButton({
    super.key,
    this.backgroundColor = CustomColors.whYellow500,
    this.foregroundColor = CustomColors.whGrey800,
    required this.buttonTitle,
    required this.onPressed,
    this.iconString = '',
    this.isDiminished = false,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String buttonTitle;
  final String iconString;
  final Function onPressed;
  final bool isDiminished;

  @override
  State<WideColoredButton> createState() => _WideColoredButtonState();
}

class _WideColoredButtonState extends State<WideColoredButton> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 100));
  bool isProgressing = false;
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
          backgroundColor: CustomColors.whGrey,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: Text(
            widget.buttonTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColors.whPlaceholderGrey,
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () async {
          _debouncer.run(() async {
            setState(() {
              isProgressing = true;
            });
            await Future.value(widget.onPressed()).whenComplete(() {
              setState(() {
                isProgressing = false;
              });
            });
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor.darken(isProgressing ? 30 : 0),
          foregroundColor: widget.foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: isProgressing
              ? LoadingAnimationWidget.waveDots(color: widget.foregroundColor, size: 24)
              : widget.iconString.isEmpty
                  ? Text(
                      widget.buttonTitle,
                      style: context.bodyLarge?.bold.copyWith(color: widget.foregroundColor),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.buttonTitle,
                          style: context.bodyLarge?.bold,
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
