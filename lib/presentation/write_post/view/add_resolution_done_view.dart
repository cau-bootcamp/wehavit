import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/group_entity/group_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/friend/friend_list_provider.dart';
import 'package:wehavit/presentation/state/group_list/group_list_provider.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_provider.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class AddResolutionDoneView extends ConsumerStatefulWidget {
  const AddResolutionDoneView({super.key});

  @override
  ConsumerState<AddResolutionDoneView> createState() => _AddResolutionDoneViewState();
}

class _AddResolutionDoneViewState extends ConsumerState<AddResolutionDoneView> {
  @override
  void initState() {
    super.initState();

    unawaited(
      ref.read(addResolutionDoneViewModelProvider.notifier).loadFriendList(),
    );
    // unawaited(
    //   ref.read(addResolutionDoneViewModelProvider.notifier).loadGroupList(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionDoneViewModelProvider);
    // final provider = ref.watch(addResolutionDoneViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '도전 추가하기 완료',
        trailingTitle: '닫기',
        trailingAction: () {
          ref.invalidate(resolutionListNotifierProvider);
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          minimum: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: CustomColors.whSemiBlack,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ResolutionListCell(
                    resolutionEntity: viewmodel.resolutionEntity!,
                    showDetails: true,
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: WideColoredButton(
                  onPressed: () async {
                    // provider.resetTempFriendList();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: ShareResolutionToFriendBottomSheetWidget(
                            resolutionEntity: viewmodel.resolutionEntity!,
                          ),
                        ),
                      ),
                    ).whenComplete(() {
                      ref.invalidate(
                        resolutionProvider(
                          ResolutionProviderParam(
                            userId: ref.read(getMyUserDataProvider).value!.userId,
                            resolutionId: viewmodel.resolutionEntity!.resolutionId,
                          ),
                        ),
                      );
                    });
                  },
                  buttonTitle: '친구에게 공유하기',
                  iconString: WHIcons.friend,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: WideColoredButton(
                  onPressed: () async {
                    // await provider.resetTempGroupList();

                    showModalBottomSheet(
                      isScrollControlled: true,
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: ShareResolutionToGroupBottomSheetWidget(resolutionEntity: viewmodel.resolutionEntity!),
                        ),
                      ),
                    );
                  },
                  buttonTitle: '그룹에게 공유하기',
                  iconString: WHIcons.group,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareResolutionToFriendBottomSheetWidget extends ConsumerStatefulWidget {
  const ShareResolutionToFriendBottomSheetWidget({required this.resolutionEntity, super.key});

  final ResolutionEntity resolutionEntity;
  @override
  ConsumerState<ShareResolutionToFriendBottomSheetWidget> createState() =>
      _ShareResolutionToFriendBottomSheetWidgetState();
}

class _ShareResolutionToFriendBottomSheetWidgetState extends ConsumerState<ShareResolutionToFriendBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WehavitAppBar(
          titleLabel: '공유할 친구 선택',
          leadingTitle: ' ',
          trailingTitle: '완료',
          trailingAction: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(friendUidListProvider).when(
              data: (friendList) {
                final asyncResolutionEntity = ref.watch(
                  resolutionProvider(
                    ResolutionProviderParam(
                      userId: ref.read(getMyUserDataProvider).value!.userId,
                      resolutionId: widget.resolutionEntity.resolutionId,
                    ),
                  ),
                );

                return asyncResolutionEntity.when(
                  data: (resolutionEntity) {
                    return Expanded(
                      child: ListView(
                        children: List<Widget>.generate(friendList.length, (index) {
                          final friendId = friendList[index];
                          final shareFriendList = resolutionEntity.shareFriendEntityList.map((e) => e.userId).toList();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: FriendSharingCell(
                              friendUid: friendId,
                              resolutionId: widget.resolutionEntity.resolutionId,
                              initStatus: shareFriendList.contains(friendId),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                  error: (_, __) {
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                );
              },
              error: (_, __) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    '잠시 후 다시 시도해주세요',
                    style: context.bodyMedium?.copyWith(
                      color: CustomColors.whGrey700,
                    ),
                  ),
                );
              },
              loading: () {
                return Container();
              },
            );
          },
        ),
      ],
    );
  }
}

class FriendSharingCell extends StatefulWidget {
  const FriendSharingCell({
    super.key,
    required this.friendUid,
    required this.resolutionId,
    required this.initStatus,
  });

  final String friendUid;
  final String resolutionId;
  final bool initStatus;

  @override
  State<FriendSharingCell> createState() => _FriendSharingCellState();
}

class _FriendSharingCellState extends State<FriendSharingCell> {
  bool currentState = false;

  @override
  void initState() {
    super.initState();
    currentState = widget.initStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return TextButton(
          onPressed: () async {
            if (currentState == false) {
              ref
                  .read(shareResolutionToFriendUsecaseProvider)
                  .call(resolutionId: widget.resolutionId, friendId: widget.friendUid)
                  .then(
                    (result) => result.fold((failure) {
                      showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                    }, (success) {
                      setState(() {
                        currentState = !currentState;
                      });
                    }),
                  );
            } else {
              ref
                  .read(unshareResolutionToFriendUsecaseProvider)
                  .call(resolutionId: widget.resolutionId, friendId: widget.friendUid)
                  .then(
                    (result) => result.fold((failure) {
                      showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                    }, (success) {
                      setState(() {
                        currentState = !currentState;
                      });
                    }),
                  );
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide.none,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            overlayColor: CustomColors.whYellow500,
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              UserProfileCell(widget.friendUid, type: UserProfileCellType.normal),
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: CircularStatusIndicator(isDone: currentState),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GroupSharingCell extends StatefulWidget {
  const GroupSharingCell({
    super.key,
    required this.groupEntity,
    required this.resolutionId,
    required this.initStatus,
  });

  final GroupEntity groupEntity;
  final String resolutionId;
  final bool initStatus;

  @override
  State<GroupSharingCell> createState() => _GroupSharingCellState();
}

class _GroupSharingCellState extends State<GroupSharingCell> {
  bool currentState = false;

  @override
  void initState() {
    super.initState();
    currentState = widget.initStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return TextButton(
          onPressed: () async {
            if (currentState == false) {
              ref
                  .read(shareResolutionToGroupUsecaseProvider)
                  .call(resolutionId: widget.resolutionId, groupId: widget.groupEntity.groupId)
                  .then(
                    (result) => result.fold((failure) {
                      showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                    }, (success) {
                      setState(() {
                        currentState = !currentState;
                      });
                    }),
                  );
            } else {
              ref
                  .read(unshareResolutionToGroupUsecaseProvider)
                  .call(resolutionId: widget.resolutionId, groupId: widget.groupEntity.groupId)
                  .then(
                    (result) => result.fold((failure) {
                      showToastMessage(context, text: '잠시 후 다시 시도해주세요');
                    }, (success) {
                      setState(() {
                        currentState = !currentState;
                      });
                    }),
                  );
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide.none,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            overlayColor: CustomColors.whYellow500,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              GroupListCell(groupEntity: widget.groupEntity),
              Container(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: CircularStatusIndicator(isDone: currentState),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShareResolutionToGroupBottomSheetWidget extends ConsumerStatefulWidget {
  const ShareResolutionToGroupBottomSheetWidget({required this.resolutionEntity, super.key});

  final ResolutionEntity resolutionEntity;

  @override
  ConsumerState<ShareResolutionToGroupBottomSheetWidget> createState() =>
      _ShareResolutionToGroupBottomSheetWidgetState();
}

class _ShareResolutionToGroupBottomSheetWidgetState extends ConsumerState<ShareResolutionToGroupBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WehavitAppBar(
          titleLabel: '공유할 그룹 선택',
          leadingTitle: ' ',
          trailingTitle: '완료',
          trailingAction: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(groupListProvider).when(
              data: (groupList) {
                final asyncResolutionEntity = ref.watch(
                  resolutionProvider(
                    ResolutionProviderParam(
                      userId: ref.read(getMyUserDataProvider).value!.userId,
                      resolutionId: widget.resolutionEntity.resolutionId,
                    ),
                  ),
                );

                return asyncResolutionEntity.when(
                  data: (resolutionEntity) {
                    return Expanded(
                      child: ListView(
                        children: List<Widget>.generate(groupList.length, (index) {
                          final groupId = groupList[index].groupId;
                          final shareGroupList = resolutionEntity.shareGroupEntityList.map((e) => e.groupId).toList();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: GroupSharingCell(
                              groupEntity: groupList[index],
                              resolutionId: widget.resolutionEntity.resolutionId,
                              initStatus: shareGroupList.contains(groupId),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                  error: (_, __) {
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                );
              },
              error: (_, __) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    '잠시 후 다시 시도해주세요',
                    style: context.bodyMedium?.copyWith(
                      color: CustomColors.whGrey700,
                    ),
                  ),
                );
              },
              loading: () {
                return Container();
              },
            );
          },
        ),
      ],
    );
  }
}
