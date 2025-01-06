import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wehavit/presentation/common_components/wh_toast_message.dart';

void showToastMessage(
  BuildContext context, {
  required String text,
}) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = WhToastMessage(
    toastLabel: text,
  );

  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
    isDismissible: true,
    positionedToastBuilder: (context, child, _) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 90,
            child: child,
          ),
        ],
      );
    },
  );
}
