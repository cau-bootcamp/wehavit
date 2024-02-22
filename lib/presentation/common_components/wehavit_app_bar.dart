import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

AppBar wehavitAppBar({
  required String title,
  String? leadingTitle,
  Function? leadingAction,
  String? trailingTitle,
  Function? trailingAction,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
        color: CustomColors.whWhite,
      ),
    ),
    leadingWidth: 80,
    leading: Visibility(
      visible: leadingTitle != null,
      child: TextButton(
        child: Text(
          leadingTitle ?? '',
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
            color: CustomColors.whWhite,
          ),
        ),
        onPressed: () {
          if (leadingAction != null) {
            leadingAction();
          }
        },
      ),
    ),
    actions: [
      Visibility(
        visible: trailingTitle != null,
        child: TextButton(
          child: Text(
            trailingTitle ?? '',
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
              color: CustomColors.whWhite,
            ),
          ),
          onPressed: () {
            if (trailingAction != null) {
              trailingAction();
            }
          },
        ),
      ),
    ],
    backgroundColor: Colors.transparent,
  );
}
