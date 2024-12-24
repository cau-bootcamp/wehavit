import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wehavit/common/constants/constants.dart';

void showToastMessage(
  BuildContext context, {
  required String text,
}) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    // width: MediaQuery.of(context).size.width - 64,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      gradient: CustomColors.toastMessageGradient,
      boxShadow: [
        BoxShadow(
          color: CustomColors.whBlack.withAlpha(64),
          offset: const Offset(0, 4),
          blurRadius: 4.0,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
    positionedToastBuilder: (context, child, _) {
      return GestureDetector(
        onTap: fToast.removeCustomToast,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 90,
              child: child,
            ),
          ],
        ),
      );
    },
  );
}
