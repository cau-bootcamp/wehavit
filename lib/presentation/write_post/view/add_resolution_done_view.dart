import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class AddResolutionDoneView extends ConsumerStatefulWidget {
  const AddResolutionDoneView({required this.resolutionEntity, super.key});

  final ResolutionEntity resolutionEntity;

  @override
  ConsumerState<AddResolutionDoneView> createState() =>
      _AddResolutionDoneViewState();
}

class _AddResolutionDoneViewState extends ConsumerState<AddResolutionDoneView> {
  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionDoneViewModelProvider);
    final provider = ref.watch(addResolutionDoneViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '도전 추가하기 완료',
        leadingTitle: '',
        trailingTitle: '닫기',
        trailingAction: () {
          // TODO: 개선하기
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
                child: ResolutionListCellWidget(
                  resolutionEntity: widget.resolutionEntity,
                  showDetails: true,
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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child:
                              const ShareResolutionToFriendBottomSheetWidget(),
                        ),
                      ),
                    );
                  },
                  buttonTitle: '친구에게 공유하기',
                  buttonIcon: Icons.search,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: WideColoredButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child:
                              const ShareResolutionToGroupBottomSheetWidget(),
                        ),
                      ),
                    );
                  },
                  buttonTitle: '그룹에게 공유하기',
                  buttonIcon: Icons.flag_outlined,
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

class _ShareResolutionToFriendBottomSheetWidgetState
    extends ConsumerState<ShareResolutionToFriendBottomSheetWidget> {
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
                onPressed: () {
                  Navigator.pop(context);
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
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: TextButton(
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
                      FriendListCellWidget(
                        futureUserEntity: viewmodel.friendList![index],
                        cellState: FriendListCellState.normal,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewmodel.selectedFriendList![index]
                              ? CustomColors.whYellow
                              : Colors.transparent,
                          border: Border.all(
                            color: CustomColors.whBrightGrey,
                          ),
                        ),
                        child: Visibility(
                          visible: viewmodel.selectedFriendList![index],
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

class ShareResolutionToGroupBottomSheetWidget extends ConsumerStatefulWidget {
  const ShareResolutionToGroupBottomSheetWidget({super.key});

  @override
  ConsumerState<ShareResolutionToGroupBottomSheetWidget> createState() =>
      _ShareResolutionToGroupBottomSheetWidgetState();
}

class _ShareResolutionToGroupBottomSheetWidgetState
    extends ConsumerState<ShareResolutionToGroupBottomSheetWidget> {
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
                onPressed: () {
                  Navigator.pop(context);
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
              viewmodel.groupModelList.length,
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
                        cellModel: viewmodel.groupModelList[index],
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
                          color: viewmodel.selectedGroupList![index]
                              ? CustomColors.whYellow
                              : Colors.transparent,
                          border: Border.all(
                            color: CustomColors.whBrightGrey,
                          ),
                        ),
                        child: Visibility(
                          visible: viewmodel.selectedGroupList![index],
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
