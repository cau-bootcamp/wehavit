import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/either_future_builder.dart';
import 'package:wehavit/presentation/common_components/user_profile_cell.dart';

class MyProfileBlock extends StatelessWidget {
  const MyProfileBlock({
    super.key,
    required this.futureUserEntity,
    this.secondaryText,
  });

  final EitherFuture<UserDataEntity> futureUserEntity;
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
        child: EitherFutureBuilder<UserDataEntity>(
          target: futureUserEntity,
          forWaiting: const UserProfileCell(
            type: UserProfileCellType.loading,
          ),
          forFail: Container(
            alignment: Alignment.center,
            child: Text(
              '정상적으로 정보를 불러오지 못했어요',
              style: context.bodyMedium?.copyWith(color: CustomColors.whGrey600),
            ),
          ),
          mainWidgetCallback: (userEntity) {
            return Row(
              children: [
                const Expanded(child: UserProfileCell(type: UserProfileCellType.profile)),
                Column(
                  children: [
                    Image.asset(
                      CustomIconImage.linkIcon,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '초대하기',
                      style: context.labelMedium,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
