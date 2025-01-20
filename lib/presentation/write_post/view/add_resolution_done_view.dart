import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

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
    unawaited(
      ref.read(addResolutionDoneViewModelProvider.notifier).loadGroupList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionDoneViewModelProvider);
    final provider = ref.watch(addResolutionDoneViewModelProvider.notifier);

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
                    provider.resetTempFriendList();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: const ShareResolutionToFriendBottomSheetWidget(),
                        ),
                      ),
                    );
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
                    await provider.resetTempGroupList();

                    showModalBottomSheet(
                      isScrollControlled: true,
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: const ShareResolutionToGroupBottomSheetWidget(),
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
  const ShareResolutionToFriendBottomSheetWidget({super.key});

  @override
  ConsumerState<ShareResolutionToFriendBottomSheetWidget> createState() =>
      _ShareResolutionToFriendBottomSheetWidgetState();
}

class _ShareResolutionToFriendBottomSheetWidgetState extends ConsumerState<ShareResolutionToFriendBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionDoneViewModelProvider);
    final provider = ref.watch(addResolutionDoneViewModelProvider.notifier);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                '공유할 친구 선택',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  provider.applyChangedSharingOfFriends().whenComplete(() {
                    Navigator.pop(context, viewmodel.resolutionEntity);
                  });
                },
                child: const Text(
                  '공유',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whWhite,
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
            children: List<Widget>.generate(
              viewmodel.friendList!.length,
              (index) => TextButton(
                onPressed: () {
                  setState(() {
                    provider.toggleFriendSelection(index);
                  });
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: BorderSide.none,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  overlayColor: CustomColors.whYellow,
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    // TODO: 수정하기
                    // FriendListCellWidget(
                    //   futureUserEntity: viewmodel.friendList![index],
                    //   cellState: FriendListCellState.normal,
                    // ),
                    // EitherFutureBuilder<UserDataEntity>(
                    //   target: viewmodel.friendList![index],
                    //   forFail: Container(),
                    //   forWaiting: Container(),
                    //   mainWidgetCallback: (_) {
                    //     return Container(
                    //       margin: const EdgeInsets.only(
                    //         right: 8.0,
                    //       ),
                    //       width: 24,
                    //       height: 24,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color:
                    //             viewmodel.tempSelectedFriendList![index] ? CustomColors.whYellow : Colors.transparent,
                    //         border: Border.all(
                    //           color: CustomColors.whBrightGrey,
                    //         ),
                    //       ),
                    //       child: Visibility(
                    //         visible: viewmodel.tempSelectedFriendList![index],
                    //         child: const Icon(
                    //           Icons.check,
                    //           color: CustomColors.whWhite,
                    //           size: 20,
                    //           weight: 500,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShareResolutionToGroupBottomSheetWidget extends ConsumerStatefulWidget {
  const ShareResolutionToGroupBottomSheetWidget({super.key});

  @override
  ConsumerState<ShareResolutionToGroupBottomSheetWidget> createState() =>
      _ShareResolutionToGroupBottomSheetWidgetState();
}

class _ShareResolutionToGroupBottomSheetWidgetState extends ConsumerState<ShareResolutionToGroupBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionDoneViewModelProvider);
    final provider = ref.watch(addResolutionDoneViewModelProvider.notifier);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                '공유할 그룹 선택',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  provider.applyChangedSharingOfGroups().whenComplete(() {
                    Navigator.pop(context, viewmodel.resolutionEntity);
                  });
                },
                child: const Text(
                  '공유',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whWhite,
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
            children: List<Widget>.generate(
              viewmodel.groupModelList?.length ?? 0,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      provider.toggleGroupSelection(index);
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide.none,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    overlayColor: CustomColors.whYellow,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GroupListViewCellWidget(
                        cellModel: viewmodel.groupModelList![index],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 16.0,
                          right: 16.0,
                        ),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewmodel.tempSelectedGroupList![index] ? CustomColors.whYellow : Colors.transparent,
                          border: Border.all(
                            color: CustomColors.whBrightGrey,
                          ),
                        ),
                        child: Visibility(
                          visible: viewmodel.tempSelectedGroupList![index],
                          child: const Icon(
                            Icons.check,
                            color: CustomColors.whWhite,
                            size: 20,
                            weight: 500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
