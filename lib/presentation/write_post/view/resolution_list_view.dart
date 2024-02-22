import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResolutionSummaryCardWidget(),
          ],
        ),
      ),
    );
  }
}

class ResolutionSummaryCardWidget extends StatelessWidget {
  const ResolutionSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.whYellow,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이번 주 나의 노력 인증 횟수',
                style: TextStyle(
                  color: CustomColors.whBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '17',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '회',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
