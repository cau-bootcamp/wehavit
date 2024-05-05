import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class GroupMemberListBottomSheet extends ConsumerStatefulWidget {
  GroupMemberListBottomSheet(
    this.updateParentViewGroupEntity, {
    super.key,
    required this.groupEntity,
  });

  GroupEntity groupEntity;
  final Function(GroupEntity) updateParentViewGroupEntity;

  @override
  ConsumerState<GroupMemberListBottomSheet> createState() =>
      _GroupMemberListBottomSheetState();
}

class _GroupMemberListBottomSheetState
    extends ConsumerState<GroupMemberListBottomSheet> {
  bool isManager = false;
  bool isManagingMode = false;
  List<String> appliedUidList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(
      ref
          .read(checkWeatherUserIsMnagerOfGroupEntityUsecaseProvider)
          (widget.groupEntity)
          .then(
        (result) {
          return result.fold((failure) => false, (result) => result);
        },
      ).then((result) {
        if (mounted) {
          setState(() {
            isManager = result;
          });
        }
      }).whenComplete(() async {
        if (isManager) {
          appliedUidList = await ref
              .watch(getAppliedUserListForGroupEntityUsecaseProvider)
              (widget.groupEntity)
              .then(
                (result) => result.fold((failure) => [], (uidList) => uidList),
              );
          if (mounted) {
            setState(() {});
          }
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBottomSheet(
      Container(
        height: MediaQuery.sizeOf(context).height * 0.80,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const Center(
                  child: Text(
                    '멤버 목록',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Visibility(
                  visible: isManager,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        isManagingMode = !isManagingMode;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.manage_accounts_outlined,
                        color: CustomColors.whWhite,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  Visibility(
                    visible: appliedUidList.isNotEmpty,
                    child: Column(
                      children: List<Widget>.generate(
                        appliedUidList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GroupMemberListCellWidget(
                            memberId: appliedUidList[index],
                            groupEntity: widget.groupEntity,
                            isManagingMode: isManagingMode,
                            isAppliedUser: true,
                            updateGroupEntity: updateGroupEntityForApply,
                          ),
                          // child: GroupMemberManageListCellWidget(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTapUp: (_) {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '가나다 순',
                              style: TextStyle(
                                color: CustomColors.whPlaceholderGrey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColors.whPlaceholderGrey,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        isManagingMode ? '그룹에서 내보내기' : '이번주 목표 달성률',
                        style: const TextStyle(
                          color: CustomColors.whPlaceholderGrey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: List<Widget>.generate(
                      widget.groupEntity.groupMemberUidList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: GroupMemberListCellWidget(
                          memberId:
                              widget.groupEntity.groupMemberUidList[index],
                          groupEntity: widget.groupEntity,
                          isManagingMode: isManagingMode,
                          isAppliedUser: false,
                          updateGroupEntity: updateGroupEntityForApply,
                        ),
                        // child: GroupMemberManageListCellWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateGroupEntityForApply(
    GroupEntity newGroupEntity,
    String appliedUserId,
  ) {
    setState(() {
      widget.groupEntity = newGroupEntity;
      appliedUidList.remove(appliedUserId);
      widget.updateParentViewGroupEntity(newGroupEntity);
    });
  }
}

class GroupMemberListCellWidget extends ConsumerStatefulWidget {
  const GroupMemberListCellWidget({
    super.key,
    required this.memberId,
    required this.groupEntity,
    required this.isManagingMode,
    required this.isAppliedUser,
    required this.updateGroupEntity,
  });

  final bool isManagingMode;
  final bool isAppliedUser;
  final String memberId;
  final GroupEntity groupEntity;
  final Function(GroupEntity, String) updateGroupEntity;

  @override
  ConsumerState<GroupMemberListCellWidget> createState() =>
      _GroupMemberListCellWidgetState();
}

class _GroupMemberListCellWidgetState
    extends ConsumerState<GroupMemberListCellWidget> {
  UserDataEntity? userEntity;
  double? achievePercentage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    unawaited(loadEntity(widget.memberId));
    if (!widget.isAppliedUser) {
      unawaited(loadAchievePercentage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.whGrey,
          ),
          width: 60,
          height: 60,
          clipBehavior: Clip.hardEdge,
          child: Visibility(
            visible: userEntity != null,
            replacement: const ColoredBox(color: CustomColors.whBrightGrey),
            child: Image.network(
              fit: BoxFit.cover,
              userEntity?.userImageUrl ?? '',
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userEntity?.userName ?? '',
                style: const TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              // Visibility(
              //   visible: !widget.isAppliedUser,
              //   child: Text(
              //     '6개의 목표 공유중',
              //     style: TextStyle(
              //       color: CustomColors.whWhite,
              //       fontSize: 14.0,
              //       fontWeight: FontWeight.w300,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),

        // Apply Mode
        Visibility(
          visible: widget.isAppliedUser,
          replacement: Visibility(
            visible: widget.isManagingMode && achievePercentage != null,
            replacement: Text(
              '${((achievePercentage ?? 0) * 100).ceil().toString()}%',
              style: const TextStyle(
                color: CustomColors.whWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Row(
              children: [
                GroupMemberListButtonWidget(
                  label: '내보내기',
                  color: CustomColors.whBrightGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          child: Row(
            children: [
              GroupMemberListButtonWidget(
                label: '거절',
                color: CustomColors.whBrightGrey,
                onPressed: () async {
                  ref
                      .watch(rejectApplyingForJoiningGroupUsecaseProvider)(
                    groupId: widget.groupEntity.groupId,
                    userId: widget.memberId,
                  )
                      .then((result) {
                    if (result.isRight()) {
                      widget.updateGroupEntity(
                        widget.groupEntity,
                        widget.memberId,
                      );
                    }
                  });
                },
              ),
              const SizedBox(width: 4.0),
              GroupMemberListButtonWidget(
                label: '수락',
                color: CustomColors.whYellow,
                onPressed: () async {
                  await ref
                      .watch(acceptApplyingForJoiningGroupUsecaseProvider)(
                    groupId: widget.groupEntity.groupId,
                    userId: widget.memberId,
                  )
                      .then((result) {
                    if (result.isRight()) {
                      final List<String> uidList = widget
                          .groupEntity.groupMemberUidList
                          .append(widget.memberId)
                          .toList();

                      widget.updateGroupEntity(
                        widget.groupEntity
                            .copyWith(groupMemberUidList: uidList),
                        widget.memberId,
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadEntity(String userId) async {
    GetUserDataFromIdUsecase getUserDataFromIdUsecase =
        ref.watch(getUserDataFromIdUsecaseProvider);
    userEntity = await getUserDataFromIdUsecase.call(widget.memberId).then(
          (result) => result.fold((failure) => null, (entity) => entity),
        );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadAchievePercentage() async {
    GetAchievementPercentageForGroupMemberUsecase
        getAchievementPercentageForGroupMemberUsecase =
        ref.watch(getAchievementPercentageForGroupMemberUsecaseProvider);

    achievePercentage = await getAchievementPercentageForGroupMemberUsecase(
      groupId: widget.groupEntity.groupId,
      userId: widget.memberId,
    ).then(
      (result) => result.fold((failure) => 0.0, (percentage) => percentage),
    );
    if (mounted) {
      setState(() {});
    }
  }
}

class GroupMemberListButtonWidget extends StatelessWidget {
  const GroupMemberListButtonWidget({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: onPressed,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: CustomColors.whDarkBlack,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
