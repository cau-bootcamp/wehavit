import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/group_post/confirm_post_provider.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_provider.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

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
  _ResolutionDetailViewState();

  DateTime selectedDate = DateTime.now().parseDateOnly();

  late List<String> resolutionList;

  @override
  void initState() {
    super.initState();
    resolutionList = [widget.entity.resolutionId]; // 여기서 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                ref,
                widget.entity,
              );
            },
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    const SizedBox(height: 16),
                    ResolutionInfo(resolutionEntity: widget.entity),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        CountAndDescription(
                          count: widget.entity.writtenPostCount,
                          unit: '회',
                          description: '실천 인증 횟수',
                        ),
                        const SizedBox(width: 16.0),
                        CountAndDescription(
                          count: widget.entity.successWeekMondayList.length,
                          unit: '일',
                          description: '주간 목표 달성 횟수',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        CountAndDescription(
                          count: widget.entity.receivedReactionCount,
                          unit: '회',
                          description: '받은 격려 수',
                        ),
                        const SizedBox(width: 16.0),
                        CountAndDescription(
                          count: DateTime.now().difference(widget.entity.startDate).inDays + 1,
                          unit: '일',
                          description: '도전을 함께한 일 수',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '요일 별 인증 횟수',
                      textAlign: TextAlign.start,
                      style: context.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ConfirmCountChart(resolutionEntity: widget.entity),
                  ],
                ),
                const SizedBox(height: 32.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '내가 쓴 인증글',
                      textAlign: TextAlign.start,
                      style: context.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Consumer(
                      builder: (context, ref, child) {
                        final asyncResolutionList = AsyncValue.data(resolutionList);

                        return asyncResolutionList.when(
                          data: (resolutionList) {
                            return Column(
                              children: [
                                WeeklyPostSwipeCalendar(
                                  resolutionList: resolutionList,
                                  firstDate: widget.entity.startDate,
                                  onSelected: (selectedDate) {
                                    setState(() {
                                      this.selectedDate = selectedDate;
                                    });
                                  },
                                ),
                                const SizedBox(height: 12.0),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final asyncEntityList = ref.watch(
                                      confirmPostListProvider(
                                        ConfirmPostProviderParam(
                                          resolutionList,
                                          selectedDate,
                                        ),
                                      ),
                                    );

                                    return asyncEntityList.when(
                                      data: (entityList) {
                                        return Visibility(
                                          visible: entityList.isNotEmpty,
                                          replacement: Container(
                                            height: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '인증글을 남기지 않은 날이예요',
                                              style: context.bodyMedium,
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: entityList.map(
                                                (entity) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(bottom: 12.0),
                                                    child: ConfirmPostListCell(
                                                      confirmPostEntity: entity,
                                                      showActions: false,
                                                      onSendCommentPressed: () {},
                                                      onEmojiPressed: () async {},
                                                      onQuickshotLongPressStart: (_) async {},
                                                      onQuickshotLongPressMove: (detail) {},
                                                      onQuickshotLongPressEnd: (detail) async {},
                                                      onQuickshotPaletteCellTapUp: (imageFilePath) async {},
                                                      onQuickshotPaletteAddCellTapUp: () {},
                                                      onQuickshotPaletteAddCellLongPressStart: (detail) async {},
                                                      onQuickshotPaletteAddCellLongPressMove: (detail) {},
                                                      onQuickshotPaletteAddCellLongPressEnd: (detail) async {},
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                      error: (_, __) {
                                        return Container(
                                          height: 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '잠시 후 다시 시도해주세요',
                                            style: context.bodyMedium,
                                          ),
                                        );
                                      },
                                      loading: () {
                                        return const Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              color: CustomColors.whGrey700,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
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
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    '곧, 더 많은 통계가 곧 추가됩니다!',
                    textAlign: TextAlign.start,
                    style: context.labelMedium?.copyWith(color: CustomColors.whGrey700),
                  ),
                ),
                const SizedBox(height: 40.0),
                Consumer(
                  builder: (context, ref, child) {
                    return WideOutlinedButton(
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
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          backgroundColor: CustomColors.whBlack,
        );
      },
    );
  }

  Future<dynamic> showModifyResolutionBottomSheet(
    BuildContext context,
    WidgetRef ref,
    ResolutionEntity entity,
  ) {
    ref.watch(addResolutionDoneViewModelProvider).resolutionEntity = entity;

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideOutlinedButton(
                buttonTitle: '목표 공유 친구 수정하기',
                iconString: WHIcons.friend,
                onPressed: () async {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) => GradientBottomSheet(
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.82,
                        child: ShareResolutionToFriendBottomSheetWidget(resolutionEntity: entity),
                      ),
                    ),
                  ).whenComplete(() {
                    ref.invalidate(
                      resolutionProvider(
                        ResolutionProviderParam(
                          userId: ref.read(getMyUserDataProvider).value!.userId,
                          resolutionId: widget.entity.resolutionId,
                        ),
                      ),
                    );
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideOutlinedButton(
                buttonTitle: '목표 공유 그룹 수정하기',
                iconString: WHIcons.group,
                onPressed: () async {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) => GradientBottomSheet(
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.82,
                        child: ShareResolutionToGroupBottomSheetWidget(resolutionEntity: entity),
                      ),
                    ),
                  ).whenComplete(() {
                    ref.invalidate(
                      resolutionProvider(
                        ResolutionProviderParam(
                          userId: ref.read(getMyUserDataProvider).value!.userId,
                          resolutionId: widget.entity.resolutionId,
                        ),
                      ),
                    );
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideOutlinedButton(
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
