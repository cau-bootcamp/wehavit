import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class GradientBottomSheet extends StatelessWidget {
  const GradientBottomSheet(
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
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              gradient: CustomColors.bottomSheetGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        height: 4,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: CustomColors.whGrey900,
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
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
