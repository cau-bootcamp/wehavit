import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';

enum UserProfileCellType {
  normal,
  deleteMode,
  invited,
  inviting,
  profile,
  groupMemberList,
  loading;
}

class UserProfileCell extends StatelessWidget {
  const UserProfileCell(
    this.userId, {
    required this.type,
    this.description = '',
    this.deleteButtonLabel = '친구 삭제',
    this.onDelete,
    this.onRequest,
    this.onAccept,
    this.onRefuse,
    super.key,
  });

  final UserProfileCellType type;
  final String userId;

  /// description이 없으면 aboutMe 가 보여진다.
  final String description;

  /// delete Type에서 deleteButtonLabel이 없으면 '친구 삭제'가 버튼의 레이블로 기본으로 보여진다.
  final String deleteButtonLabel;

  final Function? onDelete;
  final Function? onRequest;
  final Function? onAccept;
  final Function? onRefuse;

  @override
  Widget build(BuildContext context) {
    final actions = switch (type) {
      UserProfileCellType.normal => Container(),
      UserProfileCellType.profile => Container(),
      UserProfileCellType.deleteMode => SmallColoredButton(
          buttonLabel: deleteButtonLabel,
          onPressed: onDelete ?? () {},
          backgroundColor: CustomColors.whGrey600,
        ),
      UserProfileCellType.inviting => SmallColoredButton(buttonLabel: '친구 요청', onPressed: onRequest ?? () {}),
      UserProfileCellType.invited => Row(
          children: [
            SmallColoredButton(buttonLabel: '수락', onPressed: onAccept ?? () {}),
            const SizedBox(width: 8),
            SmallColoredButton(
              buttonLabel: '거절',
              onPressed: onRefuse ?? () {},
              backgroundColor: CustomColors.whGrey600,
            ),
          ],
        ),
      UserProfileCellType.groupMemberList => Container(),
      UserProfileCellType.loading => Container(),
    };

    if (type == UserProfileCellType.loading) {
      return loadingCell(actions);
    }

    return Consumer(
      builder: (context, ref, child) {
        final asyncUserEntity = ref.watch(userDataEntityProvider(userId));

        return asyncUserEntity.when(
          data: (entity) {
            return Row(
              children: [
                CircleProfileImage(size: 40, url: entity.userImageUrl),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              entity.userName,
                              style: context.bodyMedium?.bold,
                            ),
                            const SizedBox(width: 4),
                            // profile 유형이 아닐 때에만 아이디를 노출
                            // if (type != UserProfileCellType.profile)
                            Text(
                              entity.handle,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description.isNotEmpty ? description : entity.aboutMe,
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
          },
          error: (_, __) {
            return loadingCell(actions);
          },
          loading: () {
            return loadingCell(actions);
          },
        );
      },
    );
  }

  Row loadingCell(Widget actions) {
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
                      decoration: BoxDecoration(color: CustomColors.whGrey400, borderRadius: BorderRadius.circular(4)),
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
}

class ConfirmPostUserProfile extends StatelessWidget {
  const ConfirmPostUserProfile(
    this.userId, {
    required this.uploadedAt,
    super.key,
  });

  final String userId;
  final DateTime uploadedAt;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(userDataEntityProvider.call(userId)).when(
          data: (userEntity) {
            return Row(
              children: [
                CircleProfileImage(size: 40, url: userEntity.userImageUrl),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userEntity.userName,
                          style: context.bodyMedium?.bold,
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
          },
          error: (_, __) {
            return Container();
          },
          loading: () {
            return loadingCell(Container());
          },
        );
      },
    );
  }

  Row loadingCell(Widget actions) {
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
                      decoration: BoxDecoration(color: CustomColors.whGrey400, borderRadius: BorderRadius.circular(4)),
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
}
