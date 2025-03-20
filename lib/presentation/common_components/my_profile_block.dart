import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/user_profile_cell.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class MyProfileBlock extends StatelessWidget {
  const MyProfileBlock({
    super.key,
    this.secondaryText,
  });

  final String? secondaryText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        overlayColor: CustomColors.whYellow500,
        backgroundColor: CustomColors.whGrey300,
      ),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Consumer(
          builder: (context, ref, child) {
            final asyncMyUserData = ref.watch(myUserDataProvider);

            return asyncMyUserData.when(
              data: (myUserData) {
                return Row(
                  children: [
                    Expanded(child: UserProfileCell(myUserData.userId, type: UserProfileCellType.profile)),
                    // Column(
                    //   children: [
                    //     Image.asset(CustomIconImage.linkIcon, width: 20, height: 20),
                    //     const SizedBox(height: 4),
                    //     Text('초대하기', style: context.labelMedium),
                    //   ],
                    // ),
                  ],
                );
              },
              error: (_, __) {
                return const Text('잠시 후 다시 시도해주세요');
              },
              loading: () {
                return const UserProfileCell('', type: UserProfileCellType.loading);
              },
            );
          },
        ),
      ),
    );
  }
}
