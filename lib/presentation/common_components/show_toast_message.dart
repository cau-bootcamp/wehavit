import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wehavit/common/constants/constants.dart';

void showToastMessage(
  BuildContext context, {
  required String text,
  required Icon icon,
}) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    width: MediaQuery.of(context).size.width - 64,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
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
        icon,
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: CustomColors.whWhite,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
    positionedToastBuilder: (context, child) {
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
