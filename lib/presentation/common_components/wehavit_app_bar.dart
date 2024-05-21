import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

AppBar WehavitAppBar({
  required String title,
  String? leadingTitle,
  Function? leadingAction,
  IconData? leadingIcon,
  String? trailingTitle,
  Function? trailingAction,
  IconData? trailingIcon,
  int? trailingIconBadgeCount,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    centerTitle: false,
    leadingWidth: leadingTitle != null ? 135 : 0,
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
        visible: trailingTitle != null || trailingIcon != null,
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
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  trailingIcon,
                  color: CustomColors.whWhite,
                  size: trailingIcon != null ? 28.0 : 0,
                ),
                if (trailingIconBadgeCount != null &&
                    trailingIconBadgeCount > 0)
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      alignment: Alignment.center,
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.whRed,
                      ),
                      child: Text(
                        trailingIconBadgeCount.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                          color: CustomColors.whWhite,
                          height: 0.2,
                        ),
                      ),
                    ),
                  ),
              ],
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
