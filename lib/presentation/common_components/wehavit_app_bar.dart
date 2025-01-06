import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class WehavitAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WehavitAppBar({
    required this.titleLabel,
    this.leadingTitle = '',
    this.leadingAction,
    this.leadingIconString = '',
    this.trailingTitle = '',
    this.trailingAction,
    this.trailingIconString = '',
    this.trailingIconBadgeCount = 0,
    super.key,
  });

  final String titleLabel;
  final String leadingTitle;
  final String leadingIconString;
  final Function? leadingAction;
  final String trailingTitle;
  final String trailingIconString;
  final Function? trailingAction;
  final int trailingIconBadgeCount;

  @override
  Widget build(BuildContext context) {
    final isLeadingVisible = leadingTitle.isNotEmpty || leadingIconString.isNotEmpty;
    final isTrailingVisible = trailingTitle.isNotEmpty || trailingIconString.isNotEmpty;

    const Assert('isLeadingVisible && leadingAction != null', 'WehavitAppBar의 Leading Action이 포함되지 않았어요');
    const Assert('isTrailingVisible && trailingAction != null', 'WehavitAppBar의 Trailing Action이 포함되지 않았어요');

    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Text(
        titleLabel,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: CustomColors.whGrey900),
      ),
      centerTitle: isLeadingVisible ? true : false,
      leadingWidth: isLeadingVisible ? 80 : 0,
      leading: isLeadingVisible
          ? WhIconButton(
              size: WHIconsize.medium,
              buttonLabel: leadingTitle,
              iconString: leadingIconString,
              onPressed: leadingAction ?? () {},
            )
          : Container(),
      actions: [
        if (isTrailingVisible)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: WhIconButton(
              size: WHIconsize.medium,
              buttonLabel: trailingTitle,
              iconString: trailingIconString,
              onPressed: trailingAction ?? () {},
            ),
          ),
      ],
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
