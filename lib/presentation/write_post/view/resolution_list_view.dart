import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';

class ResolutionListView extends ConsumerStatefulWidget {
  const ResolutionListView({super.key});

  @override
  ConsumerState<ResolutionListView> createState() => _ResolutionListViewState();
}

class _ResolutionListViewState extends ConsumerState<ResolutionListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref
        .read(resolutionListViewModelProvider.notifier)
        .loadResolutionModelList()
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(resolutionListViewModelProvider);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: wehavitAppBar(
        title: '인증 남기기',
        leadingTitle: '닫기',
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ResolutionSummaryCardWidget(
                totalCount: viewModel.summaryTotalCount,
                doneRatio:
                    (viewModel.summaryDoneCount / viewModel.summaryTotalCount)
                        .toDouble(),
              ),
              Column(
                children: List<Widget>.generate(
                  viewModel.resolutionModelList?.length ?? 0,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      child: ResolutionListCellWidget(
                        viewModel.resolutionModelList![index],
                      ),
                      onTapUp: (details) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return GradientBottomSheet(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '목표 이름이 이렇게 들어갑니다',
                                        style: TextStyle(
                                          color: PointColors.red,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      // ResolutionLinearGaugeWidget(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  ColoredButton(
                                    buttonTitle: '인증글 작성하기',
                                    backgroundColor: CustomColors.whYellow,
                                    foregroundColor: CustomColors.whBlack,
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return WritingConfirmPostView();
                                        },
                                      ));
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: ColoredButton(
                                          buttonTitle: '반성글 작성하기',
                                          foregroundColor: Colors.red,
                                        )),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Container(
                                            width: 150,
                                            child: ColoredButton(
                                              buttonTitle: '완료 표시만 하기',
                                              foregroundColor:
                                                  CustomColors.whWhite,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  ColoredButton(
                                    buttonTitle: '돌아가기',
                                    isDiminished: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
