import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class WhToastMessage extends StatelessWidget {
  const WhToastMessage({required this.toastLabel, super.key});

  final String toastLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              toastLabel,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
