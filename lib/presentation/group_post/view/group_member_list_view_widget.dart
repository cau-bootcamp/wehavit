import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/state/group_list/group_provider.dart';
import 'package:wehavit/presentation/state/group_post/group_member_provider.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

// ignore: must_be_immutable
class GroupMemberListBottomSheet extends StatefulWidget {
  const GroupMemberListBottomSheet({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  State<GroupMemberListBottomSheet> createState() => _GroupMemberListBottomSheetState();
}

class _GroupMemberListBottomSheetState extends State<GroupMemberListBottomSheet> {
  bool isManageMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GradientBottomSheet(
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.80,
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(groupProvider(widget.groupId)).when(
                      data: (groupEntity) {
                        final isManager = groupEntity.groupManagerUid == ref.read(getMyUserDataProvider).value?.userId;

                        final newApplyCount = ref
                            .watch(getAppliedUserIdListProvider(groupEntity))
                            .when(data: (data) => data.length, error: (_, __) => 0, loading: () => 0);

                        return Column(
                          children: [
                            WehavitAppBar(
                              titleLabel: '멤버 목록',
                              leadingTitle: ' ',
                              trailingTitle: isManager ? (isManageMode ? '완료' : '') : '',
                              trailingIconString: isManager ? (isManageMode ? '' : WHIcons.friend) : '',
                              trailingIconBadgeCount: newApplyCount,
                              trailingAction: () {
                                setState(() {
                                  isManageMode = !isManageMode;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            !isManageMode
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('그룹 멤버', style: context.titleSmall),
                                            Text('이번 주 목표 달성률', style: context.bodyMedium),
                                          ],
                                        ),
                                        GroupMemberList(groupEntity, manageMode: false),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '그룹 가입 요청',
                                          style: context.titleSmall,
                                        ),
                                        GroupAppliedUserList(groupEntity),
                                        const SizedBox(height: 32),
                                        Text(
                                          '그룹 멤버',
                                          style: context.titleSmall,
                                        ),
                                        GroupMemberList(groupEntity, manageMode: true),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                      },
                      error: (_, __) => Container(),
                      loading: () => Container(),
                    );
              },
            ),
          ),
        );
      },
    );
  }
}

class GroupAppliedUserList extends StatelessWidget {
  const GroupAppliedUserList(
    this.groupEntity, {
    super.key,
  });

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(getAppliedUserIdListProvider(groupEntity)).when(
              data: (data) => data.isEmpty
                  ? Container(
                      width: double.infinity,
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        '새로운 그룹 가입 요청이 아직 없어요',
                        style: context.labelMedium?.copyWith(color: CustomColors.whGrey700),
                      ),
                    )
                  : Column(
                      children: List.generate(data.length, (index) {
                        final userId = data[index];
                        return Container(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: UserProfileCell(
                            userId,
                            type: UserProfileCellType.invited,
                            onAccept: () async {
                              ref
                                  .read(acceptApplyingForJoiningGroupUsecaseProvider)
                                  .call(groupId: groupEntity.groupId, userId: userId)
                                  .then(
                                    (result) => result.fold(
                                      (failure) {
                                        showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                                      },
                                      (success) {
                                        ref.invalidate(getAppliedUserIdListProvider(groupEntity));
                                        ref.invalidate(groupProvider(groupEntity.groupId));
                                        showToastMessage(context, text: '선택한 사용자가 이제부터 그룹과 함께합니다');
                                      },
                                    ),
                                  );
                            },
                            onRefuse: () async {
                              ref
                                  .read(rejectApplyingForJoiningGroupUsecaseProvider)
                                  .call(groupId: groupEntity.groupId, userId: userId)
                                  .then(
                                    (result) => result.fold(
                                      (failure) {
                                        showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                                      },
                                      (success) {
                                        ref.invalidate(getAppliedUserIdListProvider(groupEntity));
                                        ref.invalidate(groupProvider(groupEntity.groupId));
                                        showToastMessage(context, text: '선택한 사용자의 신청을 반려했어요');
                                      },
                                    ),
                                  );
                            },
                          ),
                        );
                      }),
                    ),
              error: (_, __) => Container(
                width: double.infinity,
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  '지금은 정보를 불러올 수 없어요\n잠시 후 다시 시도해주세요',
                  style: context.labelMedium?.copyWith(color: CustomColors.whGrey700),
                ),
              ),
              loading: () => const SizedBox(
                height: 80,
                width: double.infinity,
              ),
            );
      },
    );
  }
}

class GroupMemberList extends StatelessWidget {
  const GroupMemberList(
    this.groupEntity, {
    required this.manageMode,
    super.key,
  });

  final bool manageMode;
  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: groupEntity.groupMemberUidList.length,
        itemBuilder: (context, index) {
          final userId = groupEntity.groupMemberUidList[index];
          return Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final description = ref
                        .watch(
                          sharedResolutionCountProvider(
                            SharedResolutionCountProviderParam(
                              groupEntity.groupId,
                              userId,
                            ),
                          ),
                        )
                        .when(
                          data: (count) => '공유중인 목표 $count개',
                          error: (_, __) => ' ',
                          loading: () => '...',
                        );

                    return UserProfileCell(
                      userId,
                      type: (manageMode && userId != ref.read(getMyUserDataProvider).value!.userId)
                          ? UserProfileCellType.deleteMode
                          : UserProfileCellType.normal,
                      deleteButtonLabel: '내보내기',
                      onDelete: () async {
                        ref
                            .read(withdrawalFromGroupUsecaseProvider)
                            .call(groupId: groupEntity.groupId, targetUserId: userId)
                            .then(
                              (result) => result.fold(
                                (failure) {
                                  showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                                },
                                (success) {
                                  ref.invalidate(groupProvider(groupEntity.groupId));
                                  showToastMessage(context, text: '선택한 사용자를 그룹에서 제외했어요');
                                },
                              ),
                            );
                      },
                      description: description,
                    );
                  },
                ),
                if (!manageMode)
                  Consumer(
                    builder: (context, ref, child) {
                      return ref
                          .watch(
                        loadAchievePercentageProvider(
                          LoadAchievePercentageProviderParam(
                            groupEntity.groupId,
                            userId,
                          ),
                        ),
                      )
                          .when(
                        data: (data) {
                          return Text(
                            '${(data * 100).ceil()}%',
                            style: context.labelMedium?.bold.copyWith(
                              color: data >= 0.8 ? CustomColors.whYellow500 : CustomColors.whGrey900,
                            ),
                          );
                        },
                        error: (error, st) {
                          return Text(
                            '--',
                            style: context.labelMedium?.bold.copyWith(
                              color: CustomColors.whGrey700,
                            ),
                          );
                        },
                        loading: () {
                          return Text(
                            '--',
                            style: context.labelMedium?.bold.copyWith(
                              color: CustomColors.whGrey700,
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
