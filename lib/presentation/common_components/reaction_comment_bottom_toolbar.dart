import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class ReactionCommentBottomToolbar extends StatelessWidget {
  const ReactionCommentBottomToolbar({
    required this.onActionPressed,
    required this.commentFocusNode,
    super.key,
  });

  final FocusNode commentFocusNode;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.whGrey100,
        boxShadow: [
          const BoxShadow(
            blurRadius: 4,
            color: CustomColors.whBlack,
          ),
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 8,
            color: CustomColors.whYellow700.withOpacity(0.4),
          ),
        ],
      ),
      height: 48,
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              focusNode: commentFocusNode,
              decoration: InputDecoration(
                hintText: '000에게 코멘트 남기기',
                hintStyle: context.bodyMedium?.copyWith(color: CustomColors.whGrey600),
                border: InputBorder.none,
              ),
              cursorColor: CustomColors.whYellow500,
              style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
            ),
          ),
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
            child: Text(
              '전송하기',
              style: context.titleSmall?.bold.copyWith(color: CustomColors.whYellow500),
            ),
          ),
        ],
      ),
    );
  }
}
