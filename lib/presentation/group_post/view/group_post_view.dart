import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/group_post/group_post.dart';
import 'package:wehavit/presentation/reaction/reaction.dart';

class GroupPostView extends ConsumerStatefulWidget {
  GroupPostView({super.key, required this.groupEntity});

  GroupEntity groupEntity;

  @override
  ConsumerState<GroupPostView> createState() => _GroupPostViewState();
}

class _GroupPostViewState extends ConsumerState<GroupPostView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);
    ref.watch(groupPostViewModelProvider).groupId = widget.groupEntity.groupId;

    unawaited(
      provider
          .loadConfirmPostsForWeek(
            mondayOfTargetWeek: viewModel.calendartMondayDateList[0],
          )
          .whenComplete(() => setState(() {})),
    );

    unawaited(
      provider
          .loadConfirmPostsForWeek(
            mondayOfTargetWeek: viewModel.calendartMondayDateList[1],
          )
          .whenComplete(() => setState(() {})),
    );

    unawaited(provider.loadConfirmPostEntityListFor(dateTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);
    final reactionCameraViewModel =
        ref.watch(reactionCameraWidgetModelProvider);

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
                onPressed: () async {},
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
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return GroupMemberListBottomSheet(
                        updateGroupEntity,
                        groupEntity: widget.groupEntity,
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
                            viewModel.selectedDateString,
                            style: const TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: CustomColors.whWhite,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          padding: const EdgeInsets.only(top: 12),
                          child: CarouselSlider.builder(
                            itemBuilder: (context, index, realIndex) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List<Widget>.generate(7, (jndex) {
                                  final cellDate = viewModel.todayDate.subtract(
                                    Duration(
                                      days: viewModel.todayDate.weekday -
                                          1 -
                                          jndex +
                                          7 * index,
                                    ),
                                  );
                                  final isFuture =
                                      viewModel.todayDate.isBefore(cellDate);

                                  return Expanded(
                                    child: GestureDetector(
                                      onTapUp: (details) async {
                                        if (!isFuture) {
                                          provider
                                              .changeSelectedDate(
                                            to: cellDate,
                                          )
                                              .then((value) {
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
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
                                              const BoxShadow(
                                                blurRadius: 4,
                                                color: CustomColors.whBlack,
                                              ),
                                              BoxShadow(
                                                offset: const Offset(0, 4),
                                                blurRadius: 6,
                                                color: isFuture
                                                    ? CustomColors.whGrey
                                                    : cellDate ==
                                                            viewModel
                                                                .selectedDate
                                                        ? CustomColors.whYellow
                                                        : CustomColors
                                                            .whYellowDark,
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
                                                cellDate.day == 1
                                                    ? '${cellDate.month}/${cellDate.day}'
                                                    : cellDate.day.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: isFuture ||
                                                          cellDate !=
                                                              viewModel
                                                                  .selectedDate
                                                      ? CustomColors
                                                          .whPlaceholderGrey
                                                      : CustomColors.whBlack,
                                                ),
                                              ),
                                              Text(
                                                isFuture
                                                    ? '-'
                                                    : (viewModel.confirmPostList[
                                                                cellDate] ??
                                                            [])
                                                        .length
                                                        .toString(),
                                                style: TextStyle(
                                                  height: 1.0,
                                                  fontFamily: 'Giants',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  color: isFuture ||
                                                          cellDate !=
                                                              viewModel
                                                                  .selectedDate
                                                      ? CustomColors
                                                          .whPlaceholderGrey
                                                      : CustomColors.whBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                            itemCount: viewModel.calendartMondayDateList.length,
                            options: CarouselOptions(
                              height: 64,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: false,
                              reverse: true,
                              onPageChanged: (index, reason) async {
                                if (index ==
                                    viewModel.calendartMondayDateList.length -
                                        1) {
                                  // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
                                  viewModel.calendartMondayDateList.insert(
                                    0,
                                    viewModel.calendartMondayDateList.first
                                        .subtract(
                                      const Duration(days: 7),
                                    ),
                                  );

                                  await provider
                                      .loadConfirmPostsForWeek(
                                    mondayOfTargetWeek:
                                        viewModel.calendartMondayDateList[0],
                                  )
                                      .whenComplete(() {
                                    setState(() {});
                                  });
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
                  child: Visibility(
                    visible:
                        viewModel.confirmPostList[viewModel.selectedDate] !=
                                null &&
                            viewModel.confirmPostList[viewModel.selectedDate]!
                                .isNotEmpty,
                    replacement: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '아무도 인증글을 남기지 않은\n조용한 날이네요',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          Text(
                            '🤫',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      physics: reactionCameraViewModel.isFocusingMode
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: List<Widget>.generate(
                          viewModel.confirmPostList[viewModel.selectedDate]
                                  ?.length ??
                              0,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ConfirmPostWidget(
                              confirmPostEntity: viewModel.confirmPostList[
                                  viewModel.selectedDate]![index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const ReactionCameraWidget(),
        const ReactionAnimationWidget(),
      ],
    );
  }

  Future<void> updateGroupEntity(GroupEntity groupEntity) async {
    widget.groupEntity = groupEntity;
    ref
        .read(groupViewModelProvider.notifier)
        .updateGroupEntity(forEntity: groupEntity);
  }
}
