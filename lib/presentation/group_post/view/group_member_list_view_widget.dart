import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class GroupMemberListBottomSheet extends ConsumerStatefulWidget {
  GroupMemberListBottomSheet({
    super.key,
    required this.groupEntity,
  });

  GroupEntity groupEntity;

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
  Widget build(BuildContext context) {
    unawaited(
      ref
          .read(checkWeatherUserIsMnagerOfGroupEntityUsecaseProvider)
          (widget.groupEntity)
          .then(
        (result) {
          return result.fold((failure) => false, (result) => result);
        },
      ).then((result) {
        isManager = result;
        if (mounted) {
          setState(() {});
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
                            groupId: widget.groupEntity.groupId,
                            isManagingMode: isManagingMode,
                            isAppliedUser: true,
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
                          groupId: widget.groupEntity.groupId,
                          isManagingMode: isManagingMode,
                          isAppliedUser: false,
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
}

class GroupMemberListCellWidget extends ConsumerStatefulWidget {
  const GroupMemberListCellWidget({
    super.key,
    required this.memberId,
    required this.groupId,
    required this.isManagingMode,
    required this.isAppliedUser,
  });

  final bool isManagingMode;
  final bool isAppliedUser;
  final String memberId;
  final String groupId;

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
                onPressed: () {},
              ),
              const SizedBox(width: 4.0),
              GroupMemberListButtonWidget(
                label: '수락',
                color: CustomColors.whYellow,
                onPressed: () {},
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
      groupId: widget.groupId,
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
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: onPressed(),
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
