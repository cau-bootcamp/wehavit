import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class FriendListBottomSheet extends ConsumerStatefulWidget {
  const FriendListBottomSheet({
    super.key,
    // required this.friendIdResolutionMap,
  });

  // final Map<String, List<String>> friendIdResolutionMap;

  @override
  ConsumerState<FriendListBottomSheet> createState() => _FriendListBottomSheetState();
}

class _FriendListBottomSheetState extends ConsumerState<FriendListBottomSheet> {
  List<String> friendIdList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // friendIdList = widget.friendIdResolutionMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBottomSheet(
      Container(
        height: MediaQuery.sizeOf(context).height * 0.80,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
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
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTapUp: (_) {},
                        child: Text(
                          '친구 (${friendIdList.length})',
                          style: const TextStyle(
                            color: CustomColors.whPlaceholderGrey,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Text(
                        '이번주 목표 달성률',
                        style: TextStyle(
                          color: CustomColors.whPlaceholderGrey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  // TODO: 구현하기
                  // Column(
                  //   children: List<Widget>.generate(
                  //     widget.friendIdResolutionMap.keys.length,
                  //     (index) => Padding(
                  //       padding: const EdgeInsets.only(bottom: 12.0),
                  //       child: FriendListBottomSheetCellWidget(
                  //         memberId: friendIdList[index],
                  //         resolutionIdList: widget.friendIdResolutionMap[friendIdList[index]] ?? [],
                  //       ),
                  //       // child: GroupMemberManageListCellWidget(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendListBottomSheetCellWidget extends ConsumerStatefulWidget {
  const FriendListBottomSheetCellWidget({
    super.key,
    required this.memberId,
    required this.resolutionIdList,
  });

  final String memberId;
  final List<String> resolutionIdList;

  @override
  ConsumerState<FriendListBottomSheetCellWidget> createState() => _FriendListCellWidgetState();
}

class _FriendListCellWidgetState extends ConsumerState<FriendListBottomSheetCellWidget> {
  UserDataEntity? userEntity;
  double? achievePercentage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    unawaited(loadEntity(widget.memberId));
    unawaited(loadAchievePercentage());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleProfileImage(
          size: 60,
          url: userEntity?.userImageUrl ?? '',
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
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              // 이후에 다시 추가하기
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
        Text(
          achievePercentage == null ? '...' : '${(achievePercentage! * 100).ceil().toString()}%',
          style: const TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Future<void> loadEntity(String userId) async {
    GetUserDataFromIdUsecase getUserDataFromIdUsecase = ref.watch(getUserDataFromIdUsecaseProvider);
    userEntity = await getUserDataFromIdUsecase.call(widget.memberId).then(
          (result) => result.fold((failure) => null, (entity) => entity),
        );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadAchievePercentage() async {
    // GetTargetResolutionDoneListForWeekUsecase getTargetResolutionDoneListForWeekUsecase =
    //     ref.read(getTargetResolutionDoneListForWeekUsecaseProvider);

    GetTargetResolutionEntityUsecase getTargetResolutionEntityUsecase =
        ref.read(getTargetResolutionEntityUsecaseProvider);

    int totalPostCount = 0;
    int donePostCount = 0;

    // EitherFuture<List<bool>> doneList;
    await Future.wait(
      widget.resolutionIdList.map((id) async {
        final resolutionEntity = await getTargetResolutionEntityUsecase
            .call(
              targetUserId: widget.memberId,
              targetResolutionId: id,
            )
            .then(
              (result) => result.fold(
                (failure) => null,
                (entity) => entity,
              ),
            );

        if (resolutionEntity != null) {
          // final doneList = await getTargetResolutionDoneListForWeekUsecase(
          //     param: GetTargetResolutionDoneListForWeekUsecaseParams(
          //   resolutionId: id,
          //   startMonday: DateTime.now().getMondayDateTime(),
          // )).then(
          //   (result) => result.fold(
          //     (failure) => [] as List<bool>,
          //     (doneList) => doneList,
          //   ),
          // );

          // totalPostCount += resolutionEntity.actionPerWeek;
          // donePostCount += doneList.where((element) => element == true).length;
        }
      }),
    );

    if (totalPostCount == 0) {
      totalPostCount = 1;
    }

    setState(() {
      achievePercentage = donePostCount / totalPostCount;
    });
  }
}
