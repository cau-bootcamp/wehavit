import 'package:awesome_extensions/awesome_extensions.dart';

import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

import 'debouncer.dart';

class SmallColoredButton extends StatefulWidget {
  const SmallColoredButton({
    super.key,
    required this.buttonLabel,
    this.backgroundColor = CustomColors.whYellow,
    this.foregroundColor = CustomColors.whGrey200,
    required this.onPressed,
    this.isDisabled = false,
  });

  final String buttonLabel;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function onPressed;
  final bool isDisabled;

  @override
  State<SmallColoredButton> createState() => _SmallColoredButtonState();
}

class _SmallColoredButtonState extends State<SmallColoredButton> {
  bool isProcessing = false;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 100));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextButton(
        onPressed: () async {
          _debouncer.run(() async {
            if (!isProcessing && !widget.isDisabled) {
              setState(() {
                isProcessing = true;
              });

              await Future.value(widget.onPressed()).whenComplete(() {
                setState(() {
                  isProcessing = false;
                });
              });
            }
          });
        },
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          backgroundColor: (widget.isDisabled || isProcessing) ? CustomColors.whGrey400 : widget.backgroundColor,
          minimumSize: Size.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6.0,
          ),
          alignment: Alignment.center,
          child: Text(
            isProcessing ? '...' : widget.buttonLabel,
            style: context.labelMedium?.bold.copyWith(color: widget.foregroundColor),
          ),
        ),
      ),
    );
  }
}
