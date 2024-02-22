import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/presentation/presentation.dart';

class ResolutionListView extends StatelessWidget {
  const ResolutionListView({super.key});

  @override
  Widget build(BuildContext context) {
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
              ResolutionSummaryCardWidget(),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: ResolutionListCellWidget(),
                onTapUp: (details) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return GradientBottomSheet(
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Column(
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
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '이런걸 실천하고 있음',
                                              style: TextStyle(
                                                color: CustomColors.whWhite,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '주 ${3}회 중 ${2}회 실천',
                                              style: TextStyle(
                                                color: CustomColors.whWhite,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 7,
                                          child: LayoutBuilder(
                                            builder: (
                                              BuildContext context,
                                              BoxConstraints constraints,
                                            ) {
                                              return Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  Container(
                                                    height: 7,
                                                    width: double.infinity,
                                                    color: CustomColors
                                                        .whDarkBlack,
                                                  ),
                                                  Container(
                                                    height: 7,
                                                    width:
                                                        constraints.maxWidth *
                                                            0.7,
                                                    color: PointColors.red,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              ColoredButton(
                                buttonTitle: '인증글 작성하기',
                                backgroundColor: CustomColors.whYellow,
                                foregroundColor: CustomColors.whBlack,
                                onPressed: () {},
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
                                          foregroundColor: CustomColors.whWhite,
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
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
