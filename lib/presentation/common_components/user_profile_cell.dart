import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/utils/datetime+.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

enum UserProfileCellType {
  normal,
  deleteMode,
  invited,
  inviting,
  loading,
  profile;
}

class UserProfileCell extends StatelessWidget {
  const UserProfileCell({required this.type, super.key});

  final UserProfileCellType type;

  @override
  Widget build(BuildContext context) {
    final actions = switch (type) {
      UserProfileCellType.normal => Container(),
      UserProfileCellType.profile => Container(),
      UserProfileCellType.loading => Container(),
      UserProfileCellType.deleteMode =>
        SmallColoredButton(buttonLabel: '친구 삭제', onPressed: () {}, backgroundColor: CustomColors.whGrey600),
      UserProfileCellType.inviting => SmallColoredButton(buttonLabel: '친구 요청', onPressed: () {}),
      UserProfileCellType.invited => Row(
          children: [
            SmallColoredButton(buttonLabel: '수락', onPressed: () {}),
            const SizedBox(width: 8),
            SmallColoredButton(buttonLabel: '거절', onPressed: () {}, backgroundColor: CustomColors.whGrey600),
          ],
        ),
    };

    if (type == UserProfileCellType.loading) {
      return Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: CustomColors.whGrey400),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 18,
                        decoration:
                            BoxDecoration(color: CustomColors.whGrey400, borderRadius: BorderRadius.circular(4)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 140,
                    height: 14,
                    decoration: BoxDecoration(color: CustomColors.whGrey400, borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
            ),
          ),
          actions,
        ],
      );
    }

    return Row(
      children: [
        const CircleProfileImage(size: 40, url: 'https://cdn.sisain.co.kr/news/photo/202405/53124_99734_5711.jpg'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '닉네임',
                      style: context.bodyMedium?.bold,
                    ),
                    const SizedBox(width: 4),
                    // profile 유형이 아닐 때에만 아이디를 노출
                    if (type != UserProfileCellType.profile)
                      Text(
                        '아이디',
                        overflow: TextOverflow.ellipsis,
                        style: context.bodySmall,
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '상태 메시지',
                  style: context.labelSmall?.copyWith(color: CustomColors.whGrey800),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        actions,
      ],
    );
  }
}

class ConfirmPostUserProfile extends StatelessWidget {
  const ConfirmPostUserProfile({
    required this.userEntity,
    required this.uploadedAt,
    super.key,
  });

  final UserDataEntity userEntity;
  final DateTime uploadedAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleProfileImage(size: 40, url: 'https://cdn.sisain.co.kr/news/photo/202405/53124_99734_5711.jpg'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userEntity.userName,
                      style: context.bodyMedium?.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  uploadedAt.formatToKoreanTime(),
                  style: context.labelSmall?.copyWith(color: CustomColors.whGrey800),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
