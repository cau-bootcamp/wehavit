import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

AppBar wehavitAppBar({
  required String title,
  String? leadingTitle,
  Function? leadingAction,
  IconData? leadingIcon,
  String? trailingTitle,
  Function? trailingAction,
  IconData? trailingIcon,
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
    leadingWidth: 135,
    leading: Visibility(
      visible: leadingTitle != null,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
        ),
        icon: Icon(
          leadingIcon,
          color: CustomColors.whWhite,
          size: leadingIcon != null ? 24.0 : 0,
        ),
        label: Text(
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
            icon: Icon(
              trailingIcon,
              color: CustomColors.whWhite,
              size: trailingIcon != null ? 24.0 : 0,
            ),
            label: Text(
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
      ),
    ],
    backgroundColor: Colors.transparent,
  );
}
