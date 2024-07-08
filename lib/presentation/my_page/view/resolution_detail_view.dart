import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

// ignore: must_be_immutable
class ResolutionDetailView extends ConsumerStatefulWidget {
  ResolutionDetailView({
    super.key,
    required this.entity,
  });

  ResolutionEntity entity;
  @override
  ConsumerState<ResolutionDetailView> createState() =>
      _ResolutionDetailViewState();
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class _ResolutionDetailViewState extends ConsumerState<ResolutionDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WehavitAppBar(
        title: widget.entity.resolutionName ?? '나의 도전',
        leadingIcon: Icons.chevron_left,
        leadingAction: () {
          Navigator.pop(context);
        },
        leadingTitle: '',
        trailingTitle: '',
        trailingIcon: Icons.more_horiz,
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
                const Text(
                  '나의 목표',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: CustomColors.whGrey,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '⛳️ 나의 목표',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: PointColors
                                      .colorList[widget.entity.colorIndex ?? 0],
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.entity.goalStatement ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📋 나의 실천 계획',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: PointColors
                                      .colorList[widget.entity.colorIndex ?? 0],
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  // ignore: lines_longer_than_80_chars
                                  '${widget.entity.actionStatement ?? ''}\n일주일에 ${widget.entity.actionPerWeek ?? 0}회 실천하기',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📅 도전 시작일',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: PointColors
                                      .colorList[widget.entity.colorIndex ?? 0],
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  DateFormat('yyyy년 M월 d일').format(
                                    widget.entity.startDate ?? DateTime.now(),
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Row(
                  children: [
                    ResolutionSingleStatisticCellWidget(
                      primary: '32회',
                      secondary: '실천 인증 횟수',
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    ResolutionSingleStatisticCellWidget(
                      primary: '32회',
                      secondary: '실천 인증 횟수',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Row(
                  children: [
                    ResolutionSingleStatisticCellWidget(
                      primary: '32회',
                      secondary: '실천 인증 횟수',
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    ResolutionSingleStatisticCellWidget(
                      primary: '32회',
                      secondary: '실천 인증 횟수',
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
                const Text(
                  '요일 별 인증 횟수',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: CustomColors.whGrey,
                  ),
                  child: SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      plotAreaBorderColor: Colors.transparent,
                      primaryXAxis: const CategoryAxis(
                        majorGridLines:
                            MajorGridLines(color: Colors.transparent),
                        majorTickLines:
                            MajorTickLines(color: Colors.transparent),
                        labelStyle: TextStyle(
                          color: Colors.white, // 레이블 색상을 흰색으로 변경
                          fontSize: 14, // 폰트 크기 (옵션)
                          fontWeight: FontWeight.normal, // 폰트 굵기 (옵션)
                        ),
                      ),
                      primaryYAxis: const NumericAxis(
                        isVisible: false,
                      ),
                      series: <CartesianSeries>[
                        // Renders bar chart
                        ColumnSeries<ChartData, String>(
                          animationDuration: 750,
                          dataLabelMapper: (datum, index) =>
                              datum.y?.toInt().toString(),
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          color: PointColors
                              .colorList[widget.entity.colorIndex ?? 0],
                          dataSource: [
                            ChartData('월', 35),
                            ChartData('화', 28),
                            ChartData('수', 34),
                            ChartData('목', 32),
                            ChartData('금', 40),
                            ChartData('토', 40),
                            ChartData('일', 40),
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          width: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '내 인증글',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: CustomColors.whGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            WideColoredButton(
              buttonTitle: '목표 삭제하기',
              foregroundColor: CustomColors.whRed,
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: CustomColors.whDarkBlack,
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
                buttonIcon: Icons.people_alt_outlined,
                onPressed: () async {
                  provider.loadFriendList().whenComplete(() async {
                    await provider.resetTempFriendList();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child:
                              const ShareResolutionToFriendBottomSheetWidget(),
                        ),
                      ),
                    ).then((newEntity) {
                      widget.entity = newEntity;

                      ref
                          .watch(addResolutionDoneViewModelProvider)
                          .resolutionEntity = newEntity;
                      ref
                          .read(myPageViewModelProvider.notifier)
                          .getResolutionList()
                          .whenComplete(() {
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
                buttonIcon: Icons.flag_outlined,
                onPressed: () async {
                  provider.loadGroupList().whenComplete(() async {
                    await provider.resetTempGroupList();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child:
                              const ShareResolutionToGroupBottomSheetWidget(),
                        ),
                      ),
                    ).then((newEntity) {
                      if (newEntity != null && newEntity is ResolutionEntity) {
                        ref
                            .watch(addResolutionDoneViewModelProvider)
                            .resolutionEntity = newEntity;
                        ref
                            .read(myPageViewModelProvider.notifier)
                            .getResolutionList()
                            .whenComplete(() {
                          setState(() {});
                        });
                      }
                    });
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '목표 삭제하기',
                buttonIcon: Icons.flag_outlined,
                foregroundColor: PointColors.red,
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
                              color: PointColors.blue,
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
                                await ref
                                    .read(myPageViewModelProvider.notifier)
                                    .loadData()
                                    .whenComplete(() {
                                  context
                                      .findAncestorStateOfType<
                                          MyPageScreenState>()
                                      ?.setState(() {});
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
                        context,
                        text: '오류 발생, 문의 부탁드립니다',
                        icon: const Icon(
                          Icons.report_problem,
                          color: CustomColors.whYellow,
                        ),
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
