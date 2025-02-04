import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group_post/view/group_post_view.dart';
import 'package:wehavit/presentation/state/group_post/group_member_provider.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

// ignore: must_be_immutable
class GroupMemberListBottomSheet extends StatefulWidget {
  const GroupMemberListBottomSheet({
    super.key,
    required this.groupEntity,
  });

  final GroupEntity groupEntity;

  @override
  State<GroupMemberListBottomSheet> createState() => _GroupMemberListBottomSheetState();
}

class _GroupMemberListBottomSheetState extends State<GroupMemberListBottomSheet> {
  bool isManageMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isManager = widget.groupEntity.groupManagerUid == ref.read(getMyUserDataProvider).value?.userId;

        return GradientBottomSheet(
          Container(
            height: MediaQuery.sizeOf(context).height * 0.80,
            child: Column(
              children: [
                WehavitAppBar(
                  titleLabel: '멤버 목록',
                  leadingTitle: ' ',
                  trailingTitle: isManager ? (isManageMode ? '완료' : '') : '',
                  trailingIconString: isManager ? (isManageMode ? '' : WHIcons.friend) : '',
                  trailingIconBadgeCount: 3,
                  trailingAction: () {
                    setState(() {
                      isManageMode = !isManageMode;
                    });
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '그룹 멤버',
                            style: context.titleSmall,
                          ),
                          Text(
                            '이번 주 목표 달성률',
                            style: context.bodyMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.groupEntity.groupMemberUidList.length,
                          itemBuilder: (context, index) {
                            final userId = widget.groupEntity.groupMemberUidList[index];
                            return Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  UserProfileCell(
                                    userId,
                                    type: UserProfileCellType.normal,
                                    customDescription: '공유중인 목표 3개',
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      return ref
                                          .watch(
                                        loadAchievePercentageProvider(
                                          LoadAchievePercentageProviderParam(widget.groupEntity.groupId, userId),
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
                      ),
                    ],
                  ),
                )

                // Expanded(
                //   child: ListView(
                //     children: [
                //       Visibility(
                //         visible: isManagingMode && appliedUidList.isNotEmpty,
                //         child: Column(
                //           children: List<Widget>.generate(
                //             appliedUidList.length,
                //             (index) => Padding(
                //               padding: const EdgeInsets.only(bottom: 12.0),
                //               child: GroupMemberListCellWidget(
                //                 memberId: appliedUidList[index],
                //                 groupManagerUid: groupEntity.groupManagerUid,
                //                 groupEntity: groupEntity,
                //                 isManagingMode: isManagingMode,
                //                 isAppliedUser: true,
                //                 updateGroupEntity: updateGroupEntityForApply,
                //               ),
                //               // child: GroupMemberManageListCellWidget(),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           GestureDetector(
                //             onTapUp: (_) {},
                //             // child: const Row(
                //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             //   children: [
                //             //     Text(
                //             //       '가나다 순',
                //             //       style: TextStyle(
                //             //         color: CustomColors.whPlaceholderGrey,
                //             //         fontSize: 16.0,
                //             //         fontWeight: FontWeight.w600,
                //             //       ),
                //             //     ),
                //             //     Icon(
                //             //       Icons.keyboard_arrow_down,
                //             //       color: CustomColors.whPlaceholderGrey,
                //             //       size: 20.0,
                //             //     ),
                //             //   ],
                //             // ),
                //             child: Text(
                //               // ignore: lines_longer_than_80_chars
                //               '멤버 (${groupEntity.groupMemberUidList.length})',
                //               style: const TextStyle(
                //                 color: CustomColors.whPlaceholderGrey,
                //                 fontSize: 17.0,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //           ),
                //           Text(
                //             isManagingMode ? '그룹에서 내보내기' : '이번주 목표 달성률',
                //             style: const TextStyle(
                //               color: CustomColors.whPlaceholderGrey,
                //               fontSize: 17.0,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 16.0,
                //       ),
                //       Column(
                //         children: List<Widget>.generate(
                //           groupEntity.groupMemberUidList.length,
                //           (index) => Padding(
                //             padding: const EdgeInsets.only(bottom: 12.0),
                //             child: GroupMemberListCellWidget(
                //               memberId: groupEntity.groupMemberUidList[index],
                //               groupManagerUid: groupEntity.groupManagerUid,
                //               groupEntity: groupEntity,
                //               isManagingMode: isManagingMode,
                //               isAppliedUser: false,
                //               updateGroupEntity: updateGroupEntityForApply,
                //             ),
                //             // child: GroupMemberManageListCellWidget(),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class GroupMemberListCellWidget extends ConsumerStatefulWidget {
//   const GroupMemberListCellWidget({
//     super.key,
//     required this.memberId,
//     required this.groupManagerUid,
//     required this.groupEntity,
//     required this.isManagingMode,
//     required this.isAppliedUser,
//     required this.updateGroupEntity,
//   });

//   final bool isManagingMode;
//   final bool isAppliedUser;
//   final String memberId;
//   final String groupManagerUid;
//   final GroupEntity groupEntity;
//   final Function(GroupEntity, String) updateGroupEntity;

//   @override
//   ConsumerState<GroupMemberListCellWidget> createState() => _GroupMemberListCellWidgetState();
// }

// class _GroupMemberListCellWidgetState extends ConsumerState<GroupMemberListCellWidget> {
//   UserDataEntity? userEntity;
//   double? achievePercentage;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     unawaited(loadEntity(widget.memberId));
//     if (!widget.isAppliedUser) {
//       unawaited(loadAchievePercentage());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CircleProfileImage(
//           size: 60,
//           url: userEntity?.userImageUrl ?? '',
//         ),

//         const SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userEntity?.userName ?? '',
//                 style: const TextStyle(
//                   color: CustomColors.whWhite,
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.w600,
//                   height: 1.0,
//                 ),
//               ),
//               // 이후에 다시 추가하기
//               // Visibility(
//               //   visible: !widget.isAppliedUser,
//               //   child: Text(
//               //     '6개의 목표 공유중',
//               //     style: TextStyle(
//               //       color: CustomColors.whWhite,
//               //       fontSize: 14.0,
//               //       fontWeight: FontWeight.w300,
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),

//         // Apply Mode
//         Visibility(
//           visible: widget.isAppliedUser,
//           replacement: Visibility(
//             visible: widget.isManagingMode && achievePercentage != null,
//             replacement: Text(
//               '${((achievePercentage ?? 0) * 100).ceil().toString()}%',
//               style: const TextStyle(
//                 color: CustomColors.whWhite,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Visibility(
//                   visible: widget.groupManagerUid != widget.memberId,
//                   child: SmallColoredButton(
//                     buttonLabel: '내보내기',
//                     backgroundColor: CustomColors.whBrightGrey,
//                     onPressed: () async {
//                       await ref
//                           .watch(withdrawalFromGroupUsecaseProvider)(
//                         groupId: widget.groupEntity.groupId,
//                         targetUserId: widget.memberId,
//                       )
//                           .then((result) {
//                         if (result.isRight()) {
//                           final List<String> uidList = widget.groupEntity.groupMemberUidList
//                               .where((element) => element != widget.memberId)
//                               .toList();

//                           widget.updateGroupEntity(
//                             widget.groupEntity.copyWith(groupMemberUidList: uidList),
//                             widget.memberId,
//                           );
//                         }
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           child: Row(
//             children: [
//               SmallColoredButton(
//                 buttonLabel: '거절',
//                 backgroundColor: CustomColors.whBrightGrey,
//                 onPressed: () async {
//                   ref
//                       .watch(rejectApplyingForJoiningGroupUsecaseProvider)(
//                     groupId: widget.groupEntity.groupId,
//                     userId: widget.memberId,
//                   )
//                       .then((result) {
//                     if (result.isRight()) {
//                       widget.updateGroupEntity(
//                         widget.groupEntity,
//                         widget.memberId,
//                       );
//                     }
//                   });
//                 },
//               ),
//               const SizedBox(width: 4.0),
//               SmallColoredButton(
//                 buttonLabel: '수락',
//                 onPressed: () async {
//                   await ref
//                       .watch(acceptApplyingForJoiningGroupUsecaseProvider)(
//                     groupId: widget.groupEntity.groupId,
//                     userId: widget.memberId,
//                   )
//                       .then((result) {
//                     if (result.isRight()) {
//                       final List<String> uidList =
//                           widget.groupEntity.groupMemberUidList.append(widget.memberId).toList();

//                       widget.updateGroupEntity(
//                         widget.groupEntity.copyWith(groupMemberUidList: uidList),
//                         widget.memberId,
//                       );
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> loadEntity(String userId) async {
//     GetUserDataFromIdUsecase getUserDataFromIdUsecase = ref.watch(getUserDataFromIdUsecaseProvider);
//     userEntity = await getUserDataFromIdUsecase.call(widget.memberId).then(
//           (result) => result.fold((failure) => null, (entity) => entity),
//         );

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future<void> loadAchievePercentage() async {
//     GetAchievementPercentageForGroupMemberUsecase getAchievementPercentageForGroupMemberUsecase =
//         ref.watch(getAchievementPercentageForGroupMemberUsecaseProvider);

//     achievePercentage = await getAchievementPercentageForGroupMemberUsecase(
//       groupId: widget.groupEntity.groupId,
//       userId: widget.memberId,
//     ).then(
//       (result) => result.fold((failure) => 0.0, (percentage) => percentage),
//     );
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
