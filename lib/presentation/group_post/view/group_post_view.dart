import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';
import 'package:wehavit/presentation/group_post/view/group_post_view_widget.dart';
import 'package:wehavit/presentation/reaction/reaction.dart';

class GroupPostView extends ConsumerStatefulWidget {
  const GroupPostView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  ConsumerState<GroupPostView> createState() => _GroupPostViewState();
}

class _GroupPostViewState extends ConsumerState<GroupPostView> {
  Point<double> panPosition = Point<double>(0, 0);
  List<DateTime> calendartMondayDateList = [
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 7)),
  ];

  late final ConfirmPostEntity postEntity;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ref.read(groupPostViewModelProvider.notifier).initializeCamera();

    ref
        .watch(getMyResolutionListUsecaseProvider)
        .call(NoParams())
        .then((value) => value.fold((l) => null, (r) => r.first))
        .then((value) async {
      if (value != null) {
        final resEntity = value;
        final confirmPostEntity = await ref
            .watch(getConfirmPostListForResolutionIdUsecaseProvider)
            (resEntity!.resolutionId ?? '')
            .then(
          (value) {
            return value.fold(
              (l) => null,
              (pList) => pList.first,
            );
          },
        );
        return confirmPostEntity;
      }
    }).then((value) {
      postEntity = value!;
    }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);
    final reactionModel = ref.watch(reactionCameraWidgetModelProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.whBlack,
          appBar: AppBar(
            backgroundColor: CustomColors.whBlack,
            scrolledUnderElevation: 0,
            title: Text(
              widget.groupEntity.groupName,
              style: const TextStyle(
                color: CustomColors.whWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.campaign_outlined,
                  color: CustomColors.whWhite,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.error_outline,
                  color: CustomColors.whWhite,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () async {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return GradientBottomSheet(
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.80,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '멤버 목록',
                                      style: TextStyle(
                                        color: CustomColors.whWhite,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.manage_accounts_outlined,
                                        color: CustomColors.whWhite,
                                        size: 24.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTapUp: (_) {},
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '가나다 순',
                                            style: TextStyle(
                                              color: CustomColors
                                                  .whPlaceholderGrey,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color:
                                                CustomColors.whPlaceholderGrey,
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '이번주 목표 달성률',
                                    style: TextStyle(
                                      color: CustomColors.whPlaceholderGrey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Expanded(
                                child: Column(
                                  children: List<Widget>.generate(
                                    7,
                                    (index) => Padding(
                                      padding: EdgeInsets.only(bottom: 12.0),
                                      child: GroupMemberManageListCellWidget(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.people_outline,
                  color: CustomColors.whWhite,
                  size: 30,
                ),
              ),
            ],
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16.0),
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '2024년 2월 27일',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CustomColors.whWhite,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          padding: EdgeInsets.only(top: 12),
                          child: CarouselSlider.builder(
                            itemBuilder: (context, index, realIndex) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List<Widget>.generate(
                                  7,
                                  (jndex) => Expanded(
                                    child: GestureDetector(
                                      onTapUp: (details) {
                                        print('tap date');
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        height: 64,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: CustomColors.whBlack,
                                              width: 2,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                offset: Offset(0, 0),
                                                color: CustomColors.whBlack,
                                              ),
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 6,
                                                color: CustomColors.whYellow,
                                                // color: CustomColors.whGrey,
                                                // color: CustomColors.whYellowDark,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '30',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  // color: CustomColors.whPlaceholderGrey,
                                                  color: CustomColors.whBlack,
                                                ),
                                              ),
                                              Text(
                                                index.toString(),
                                                style: TextStyle(
                                                  height: 1.0,
                                                  fontFamily: 'Giants',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  // color: CustomColors.whPlaceholderGrey,
                                                  color: CustomColors.whBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: calendartMondayDateList.length,
                            options: CarouselOptions(
                              height: 64,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: false,
                              reverse: true,
                              initialPage: calendartMondayDateList.length - 1,
                              onPageChanged: (index, reason) {
                                if (index ==
                                    calendartMondayDateList.length - 1) {
                                  // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
                                  calendartMondayDateList.insert(
                                    0,
                                    calendartMondayDateList.first.subtract(
                                      const Duration(days: 7),
                                    ),
                                  );
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    physics: reactionModel.isFocusingMode
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ConfirmPostWidget(
                          panEndCallback: endOnCapturingPosition,
                          panUpdateCallback: updatePanPosition,
                          confirmPostEntity: postEntity,
                        ),
                        const SizedBox(height: 12.0),
                        ConfirmPostWidget(
                          panEndCallback: endOnCapturingPosition,
                          panUpdateCallback: updatePanPosition,
                          confirmPostEntity: postEntity,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (viewModel.isCameraInitialized)
          ReactionCameraWidget(
            cameraController: viewModel.cameraController,
            panPosition: panPosition,
          ),
        const ReactionAnimationWidget(),
      ],
    );
  }

  void updatePanPosition(Point<double> position) {
    setState(() {
      panPosition = position;
    });
  }

  Future<void> endOnCapturingPosition(
    Point<double> position,
    ConfirmPostEntity entity,
  ) async {
    final imageFilePath =
        await ref.watch(reactionCameraWidgetModelProvider.notifier).capture();

    ref
        .read(groupPostViewModelProvider.notifier)
        .sendImageReaction(imageFilePath: imageFilePath, entity: entity);
  }
}
