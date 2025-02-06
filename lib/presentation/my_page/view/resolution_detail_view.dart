import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

// ignore: must_be_immutable
class ResolutionDetailView extends ConsumerStatefulWidget {
  ResolutionDetailView({
    super.key,
    required this.entity,
  });

  ResolutionEntity entity;
  @override
  ConsumerState<ResolutionDetailView> createState() => _ResolutionDetailViewState();
}

class _ResolutionDetailViewState extends ConsumerState<ResolutionDetailView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final viewmodel = ref.watch(resolutionDetailViewModelProvider);
    final provider = ref.read(resolutionDetailViewModelProvider.notifier);

    viewmodel.resolutionEntity = widget.entity;

    unawaited(
      provider
          .loadConfirmPostsForWeek(
            mondayOfTargetWeek: viewmodel.calendartMondayDateList[0],
          )
          .whenComplete(() => setState(() {})),
    );

    unawaited(
      provider
          .loadConfirmPostsForWeek(
            mondayOfTargetWeek: viewmodel.calendartMondayDateList[1],
          )
          .whenComplete(() => setState(() {})),
    );

    unawaited(provider.loadConfirmPostEntityListFor(dateTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(resolutionDetailViewModelProvider);
    final provider = ref.read(resolutionDetailViewModelProvider.notifier);

    return Scaffold(
      appBar: WehavitAppBar(
        titleLabel: widget.entity.resolutionName,
        leadingIconString: WHIcons.back,
        leadingAction: () {
          Navigator.pop(context);
        },
        trailingIconString: WHIcons.more,
        trailingAction: () async {
          showModifyResolutionBottomSheet(
            context,
            widget.entity,
          );
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나의 도전',
                  textAlign: TextAlign.start,
                  style: context.headlineSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                ResolutionInfo(
                  resolutionEntity: widget.entity,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    CountAndDescription(
                      count: widget.entity.writtenPostCount,
                      unit: '회',
                      description: '실천 인증 횟수',
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    CountAndDescription(
                      count: widget.entity.successWeekMondayList.length,
                      unit: '일',
                      description: '주간 목표 달성 횟수',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    CountAndDescription(
                      count: widget.entity.receivedReactionCount,
                      unit: '회',
                      description: '받은 격려 수',
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    CountAndDescription(
                      count: DateTime.now().difference(widget.entity.startDate).inDays + 1,
                      unit: '일',
                      description: '도전을 함께한 일 수',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '요일 별 인증 횟수',
                  textAlign: TextAlign.start,
                  style: context.headlineSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                ConfirmCountChart(resolutionEntity: widget.entity),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '내가 쓴 인증글',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Column(
                  children: [
                    Text(
                      viewModel.selectedDateString,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whPlaceholderGrey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    putScrollableCalendarWidget(viewModel, provider),
                    const SizedBox(
                      height: 12.0,
                    ),
                    EitherFutureBuilder<List<ConfirmPostEntity>>(
                      target: viewModel.confirmPostList[viewModel.selectedDate],
                      forWaiting: const Center(
                        child: SizedBox(
                          height: 252,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: CustomColors.whBrightGrey,
                          ),
                        ),
                      ),
                      forFail: const SizedBox(
                        height: 150,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '이 날에는 인증글을 남기지 않았어요',
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
                      ),
                      mainWidgetCallback: (entityList) {
                        return Visibility(
                          visible: entityList.isNotEmpty,
                          replacement: const SizedBox(
                            height: 252,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '이 날에는 인증글을 남기지 않았어요',
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
                                ],
                              ),
                            ),
                          ),
                          child: Column(
                            children: List<Widget>.generate(
                              entityList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: ConfirmPostListCell(
                                  confirmPostEntity: entityList[index],
                                  onSendCommentPressed: () {},
                                  onEmojiPressed: () {},
                                  showActions: false,
                                  onQuickshotLongPressStart: (_) {},
                                  onQuickshotLongPressMove: (_) {},
                                  onQuickshotLongPressEnd: (_) {},
                                  onQuickshotPaletteCellTapUp: (_) {},
                                  onQuickshotPaletteAddCellTapUp: () {},
                                  onQuickshotPaletteAddCellLongPressStart: (_) {},
                                  onQuickshotPaletteAddCellLongPressMove: (_) {},
                                  onQuickshotPaletteAddCellLongPressEnd: (_) {},
                                  // ConfirmPostWidget(
                                  //   confirmPostEntity: entityList[index],
                                  //   createdDate: viewModel.selectedDate,
                                  //   showReactionToolbar: false,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                '곧, 더 많은 통계가 곧 추가됩니다!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: CustomColors.whSemiWhite,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            WideColoredButton(
              buttonTitle: '목표 삭제하기',
              foregroundColor: CustomColors.whRed,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        '목표 삭제하기',
                        style: TextStyle(color: CustomColors.whGrey100),
                      ),
                      content: Text(
                        '${widget.entity.resolutionName} 을 비활성화 하시겠어요?\n해당 목표는 작성하기에서 숨김 처리됩니다.',
                        style: const TextStyle(color: CustomColors.whGrey100),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            '취소',
                            style: TextStyle(color: CustomColors.whGrey300),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            '삭제하기',
                            style: TextStyle(color: CustomColors.whRed500),
                          ),
                          onPressed: () async {
                            // TODO: 삭제하기 로직 정리하기
                            await ref
                                .read(setResolutionDeactiveUsecaseProvider)
                                .call(resolutionId: widget.entity.resolutionId, entity: widget.entity)
                                .whenComplete(() {
                              setState(() {
                                ref.invalidate(resolutionListNotifierProvider);
                              });
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                ref.invalidate(resolutionListNotifierProvider);
              },
            ),
          ],
        ),
      ),
      backgroundColor: CustomColors.whBlack,
    );
  }

  ProviderScope putScrollableCalendarWidget(
    ResolutionDetailViewModel viewModel,
    ResolutionDetailViewModelProvider provider,
  ) {
    return ProviderScope(
      child: CarouselSlider.builder(
        itemBuilder: (context, index, realIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(7, (jndex) {
              final cellDate = viewModel.todayDate.subtract(
                Duration(
                  days: viewModel.todayDate.weekday - 1 - jndex + 7 * index,
                ),
              );
              final isFuture = viewModel.todayDate.isBefore(cellDate);
              final isPast = widget.entity.startDate.subtract(const Duration(days: 1)).isAfter(cellDate);

              return Expanded(
                child: GestureDetector(
                  onTapUp: (details) async {
                    if (!isFuture && !isPast) {
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
                      horizontal: 4.0,
                    ),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.whBlack,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                            blurRadius: 4,
                            color: CustomColors.whBlack,
                          ),
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                            color: (isFuture || isPast)
                                ? CustomColors.whGrey
                                : cellDate == viewModel.selectedDate
                                    ? CustomColors.whYellow
                                    : CustomColors.whYellowDark,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                cellDate.day == 1 ? '${cellDate.month}/${cellDate.day}' : cellDate.day.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (isFuture || isPast) || cellDate != viewModel.selectedDate
                                      ? CustomColors.whPlaceholderGrey
                                      : CustomColors.whBlack,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Visibility(
                                visible: !isFuture,
                                replacement: Text(
                                  '-',
                                  style: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Giants',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: (isFuture || isPast) || cellDate != viewModel.selectedDate
                                        ? CustomColors.whPlaceholderGrey
                                        : CustomColors.whBlack,
                                  ),
                                ),
                                child: EitherFutureBuilder<List<ConfirmPostEntity>>(
                                  target: viewModel.confirmPostList[cellDate],
                                  forWaiting: const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        2.0,
                                      ),
                                      child: CircularProgressIndicator(
                                        color: CustomColors.whBrightGrey,
                                      ),
                                    ),
                                  ),
                                  forFail: const Text('-'),
                                  mainWidgetCallback: (entityList) => Text(
                                    entityList.length.toString(),
                                    style: TextStyle(
                                      height: 1.0,
                                      fontFamily: 'Giants',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: (isFuture || isPast) || cellDate != viewModel.selectedDate
                                          ? CustomColors.whPlaceholderGrey
                                          : CustomColors.whBlack,
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
            if (index == viewModel.calendartMondayDateList.length - 1) {
              if (widget.entity.startDate.isAfter(viewModel.calendartMondayDateList.first)) {
                return;
              }
              // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
              viewModel.calendartMondayDateList.insert(
                0,
                viewModel.calendartMondayDateList.first.subtract(
                  const Duration(days: 7),
                ),
              );

              await provider
                  .loadConfirmPostsForWeek(
                mondayOfTargetWeek: viewModel.calendartMondayDateList[0],
              )
                  .whenComplete(() {
                setState(() {});
              });
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> showModifyResolutionBottomSheet(
    BuildContext context,
    ResolutionEntity entity,
  ) {
    ref.watch(addResolutionDoneViewModelProvider).resolutionEntity = entity;
    final provider = ref.read(addResolutionDoneViewModelProvider.notifier);

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideColoredButton(
                buttonTitle: '목표 공유 친구 수정하기',
                iconString: WHIcons.friend,
                onPressed: () async {
                  provider.loadFriendList().whenComplete(() async {
                    // await provider.resetTempFriendList();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: const ShareResolutionToFriendBottomSheetWidget(),
                        ),
                      ),
                    ).then((newEntity) {
                      widget.entity = newEntity;

                      ref.watch(addResolutionDoneViewModelProvider).resolutionEntity = newEntity;
                      ref.read(myPageViewModelProvider.notifier).getResolutionList().whenComplete(() {
                        setState(() {});
                      });
                    });
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '목표 공유 그룹 수정하기',
                iconString: WHIcons.group,
                onPressed: () async {
                  // provider.loadGroupList().whenComplete(() async {
                  //   // await provider.resetTempGroupList();
                  //   showModalBottomSheet(
                  //     isScrollControlled: true,
                  //     // ignore: use_build_context_synchronously
                  //     context: context,
                  //     builder: (context) => GradientBottomSheet(
                  //       SizedBox(
                  //         height: MediaQuery.of(context).size.height * 0.82,
                  //         child: const ShareResolutionToGroupBottomSheetWidget(),
                  //       ),
                  //     ),
                  //   ).then((newEntity) {
                  //     if (newEntity != null && newEntity is ResolutionEntity) {
                  //       ref.watch(addResolutionDoneViewModelProvider).resolutionEntity = newEntity;
                  //       ref.read(myPageViewModelProvider.notifier).getResolutionList().whenComplete(() {
                  //         setState(() {});
                  //       });
                  //     }
                  //   });
                  // });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '목표 삭제하기',
                iconString: WHIcons.delete,
                foregroundColor: CustomColors.pointRed,
                onPressed: () async {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('정말 삭제하시겠어요?'),
                        content: const Text('목표에 대해 작성하신 인증 글은 유지됩니다'),
                        actions: [
                          CupertinoDialogAction(
                            textStyle: const TextStyle(
                              color: CustomColors.pointBlue,
                            ),
                            isDefaultAction: true,
                            child: const Text('취소'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              ref
                                  .read(myPageViewModelProvider.notifier)
                                  .deactiveResolution(
                                    targetResolutionEntity: entity,
                                  )
                                  .whenComplete(() async {
                                ref
                                    .read(
                                      resolutionListViewModelProvider.notifier,
                                    )
                                    .loadResolutionModelList();
                                await ref.read(myPageViewModelProvider.notifier).loadData().whenComplete(() {
                                  // ignore: use_build_context_synchronously
                                  context.findAncestorStateOfType<MyPageScreenState>()?.setState(() {});
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                setState(() {});
                              });
                            },
                            child: const Text('삭제'),
                          ),
                        ],
                      );
                    },
                  ).then((result) {
                    if (result == false) {
                      showToastMessage(
                        // ignore: use_build_context_synchronously
                        context,
                        text: '오류 발생, 문의 부탁드립니다',
                      );
                    }
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '돌아가기',
                backgroundColor: Colors.transparent,
                foregroundColor: CustomColors.whPlaceholderGrey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ResolutionSingleStatisticCellWidget extends StatelessWidget {
  const ResolutionSingleStatisticCellWidget({
    super.key,
    required this.primary,
    required this.secondary,
  });

  final String primary;
  final String secondary;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: CustomColors.whGrey,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                primary,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: CustomColors.whWhite,
                  fontSize: 22,
                ),
              ),
              Text(
                secondary,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: CustomColors.whPlaceholderGrey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
