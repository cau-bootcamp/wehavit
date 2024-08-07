import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class GradientBottomSheet extends StatelessWidget {
  GradientBottomSheet(
    this.content, {
    super.key,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.only(bottom: 24),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              gradient: CustomColors.bottomSheetGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      width: 72,
                      decoration: const BoxDecoration(
                        color: CustomColors.whPlaceholderGrey,
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    content,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
